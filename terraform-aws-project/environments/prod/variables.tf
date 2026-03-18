variable "aws_region" {
  description = "AWS region where the prod environment is deployed."
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
  description = "CIDR block for the prod VPC."
  type        = string
}

variable "availability_zones" {
  description = "Two AZs used by the prod environment."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks for the prod environment."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks for the prod environment."
  type        = list(string)
}

variable "common_tags" {
  description = "Additional tags shared by all resources in the prod environment."
  type        = map(string)
  default     = {}
}

variable "alb_ingress_cidr_blocks" {
  description = "CIDR blocks allowed to reach the prod ALB."
  type        = list(string)
}

variable "alb_listener_port" {
  description = "Listener port exposed by the prod ALB."
  type        = number
}

variable "app_port" {
  description = "Port exposed by the application behind the prod ALB."
  type        = number
}

variable "health_check_path" {
  description = "Health check path used by the prod ALB target group."
  type        = string
}

variable "alb_enable_deletion_protection" {
  description = "Whether deletion protection is enabled on the prod ALB."
  type        = bool
}
