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
