variable "name" {
  description = "Base name shared by the ALB resources."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB and target group are created."
  type        = string
}

variable "subnet_ids" {
  description = "Public subnet IDs used by the ALB."
  type        = list(string)
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks allowed to reach the ALB listener."
  type        = list(string)
}

variable "listener_port" {
  description = "Port exposed by the ALB listener."
  type        = number
}

variable "target_port" {
  description = "Application port exposed by the downstream service."
  type        = number
}

variable "health_check_path" {
  description = "HTTP path used by the target group health check."
  type        = string
}

variable "internal" {
  description = "Whether the ALB is internal-only."
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Whether deletion protection is enabled on the ALB."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to all ALB resources."
  type        = map(string)
  default     = {}
}
