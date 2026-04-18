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

variable "ecr_image_tag_mutability" {
  description = "Whether ECR image tags are mutable in prod."
  type        = string
}

variable "ecr_scan_on_push" {
  description = "Whether pushed images are scanned in prod ECR."
  type        = bool
}

variable "ecr_max_image_count" {
  description = "Maximum number of images retained in the prod ECR repository."
  type        = number
}

variable "app_image_tag" {
  description = "Image tag deployed by the ECS service."
  type        = string
}

variable "ecs_cpu" {
  description = "CPU units for the prod ECS task definition."
  type        = number
}

variable "ecs_memory" {
  description = "Memory in MiB for the prod ECS task definition."
  type        = number
}

variable "ecs_desired_count" {
  description = "Desired number of running tasks in the prod ECS service."
  type        = number
}

variable "ecs_enable_execute_command" {
  description = "Whether ECS Exec is enabled in the prod ECS service."
  type        = bool
}

variable "app_environment" {
  description = "Environment variables injected into the prod ECS container."
  type        = map(string)
  default     = {}
}
