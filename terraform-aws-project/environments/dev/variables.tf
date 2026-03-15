variable "aws_region" {
  description = "AWS region where the dev environment is deployed."
  type        = string
}

variable "project_name" {
  description = "Stable project identifier used in names and tags."
  type        = string
}

variable "environment" {
  description = "Environment name used in tags and naming conventions."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the dev VPC."
  type        = string
}

variable "availability_zones" {
  description = "Two AZs used by the dev environment."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks for the dev environment."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks for the dev environment."
  type        = list(string)
}

variable "common_tags" {
  description = "Additional tags shared by all resources in the dev environment."
  type        = map(string)
  default     = {}
}
