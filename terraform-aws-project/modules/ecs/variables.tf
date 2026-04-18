variable "name" {
	description = "Base name used by ECS resources."
	type        = string
}

variable "aws_region" {
	description = "AWS region used for CloudWatch log configuration."
	type        = string
}

variable "vpc_id" {
	description = "VPC ID where the ECS service runs."
	type        = string
}

variable "private_subnet_ids" {
	description = "Private subnet IDs for ECS tasks."
	type        = list(string)
}

variable "alb_security_group_id" {
	description = "Security group ID of the upstream ALB allowed to reach ECS tasks."
	type        = string
}

variable "target_group_arn" {
	description = "Target group ARN where ECS tasks are registered."
	type        = string
}

variable "container_name" {
	description = "Name of the container definition."
	type        = string
	default     = "app"
}

variable "container_image" {
	description = "Container image URL used by the task definition."
	type        = string
}

variable "container_port" {
	description = "Container port exposed by the application."
	type        = number
}

variable "cpu" {
	description = "Task CPU units for Fargate."
	type        = number
	default     = 256
}

variable "memory" {
	description = "Task memory (MiB) for Fargate."
	type        = number
	default     = 512
}

variable "desired_count" {
	description = "Desired number of ECS tasks."
	type        = number
	default     = 1
}

variable "assign_public_ip" {
	description = "Whether ECS tasks receive public IPs."
	type        = bool
	default     = false
}

variable "enable_execute_command" {
	description = "Whether ECS Exec is enabled on the service."
	type        = bool
	default     = false
}

variable "environment_variables" {
	description = "Map of environment variables injected into the container."
	type        = map(string)
	default     = {}
}

variable "tags" {
	description = "Tags applied to ECS resources."
	type        = map(string)
	default     = {}
}
