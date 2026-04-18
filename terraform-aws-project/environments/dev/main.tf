terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  base_tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    # Provider-level tags reduce drift because every child resource gets the same ownership metadata by default.
    tags = merge(local.base_tags, var.common_tags)
  }
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = "${var.project_name}-${var.environment}"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  tags                 = merge(local.base_tags, var.common_tags)
}

module "alb" {
  source = "../../modules/alb"

  name                       = "${var.project_name}-${var.environment}"
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.public_subnet_ids
  ingress_cidr_blocks        = var.alb_ingress_cidr_blocks
  listener_port              = var.alb_listener_port
  target_port                = var.app_port
  health_check_path          = var.health_check_path
  enable_deletion_protection = var.alb_enable_deletion_protection
  tags                       = merge(local.base_tags, var.common_tags)
}

module "ecr" {
  source = "../../modules/ecr"

  name                 = "${var.project_name}-${var.environment}"
  image_tag_mutability = var.ecr_image_tag_mutability
  scan_on_push         = var.ecr_scan_on_push
  max_image_count      = var.ecr_max_image_count
  tags                 = merge(local.base_tags, var.common_tags)
}

module "ecs" {
  source = "../../modules/ecs"

  name                   = "${var.project_name}-${var.environment}"
  aws_region             = var.aws_region
  vpc_id                 = module.vpc.vpc_id
  private_subnet_ids     = module.vpc.private_subnet_ids
  alb_security_group_id  = module.alb.security_group_id
  target_group_arn       = module.alb.target_group_arn
  container_name         = "app"
  container_image        = "${module.ecr.repository_url}:${var.app_image_tag}"
  container_port         = var.app_port
  cpu                    = var.ecs_cpu
  memory                 = var.ecs_memory
  desired_count          = var.ecs_desired_count
  enable_execute_command = var.ecs_enable_execute_command
  environment_variables  = var.app_environment
  tags                   = merge(local.base_tags, var.common_tags)

  depends_on = [module.alb]
}
