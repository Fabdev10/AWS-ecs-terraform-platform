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

variable "alb_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to reach the dev ALB."
  type        = list(string)
}

variable "alb_listener_port" {
  description = "Listener port exposed by the dev ALB."
  type        = number
}

variable "app_port" {
  description = "Port exposed by the application behind the dev ALB."
  type        = number
}

variable "health_check_path" {
  description = "Health check path used by the dev ALB target group."
  type        = string
}

variable "alb_enable_deletion_protection" {
  description = "Whether deletion protection is enabled on the dev ALB."
  type        = bool
}
