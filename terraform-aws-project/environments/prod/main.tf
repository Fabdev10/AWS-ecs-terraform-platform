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
    # Default provider tags make later module additions safer because shared ownership metadata stays centralized.
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
