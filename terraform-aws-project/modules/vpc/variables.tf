variable "name" {
  description = "Name prefix used to keep shared networking resources identifiable across environments."
  type        = string
}

variable "vpc_cidr" {
  description = "Primary CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Exactly two AZs are required here so later ALB, ECS, and RDS layers have a resilient network foundation."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Provide exactly two availability zones."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets that will host internet-facing resources such as the ALB and NAT gateways."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Provide exactly two public subnet CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets that will host ECS tasks and the database tier."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Provide exactly two private subnet CIDR blocks."
  }
}

variable "enable_dns_support" {
  description = "DNS support stays enabled so service discovery and RDS endpoints work without extra network plumbing later."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "DNS hostnames stay enabled because ECS and load balancers rely on AWS-managed names in normal production setups."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags applied to all networking resources."
  type        = map(string)
  default     = {}
}
