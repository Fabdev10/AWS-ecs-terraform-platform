output "vpc_id" {
  description = "Dev VPC ID."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs for the dev environment."
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs for the dev environment."
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_public_ips" {
  description = "NAT Gateway public IPs for the dev environment."
  value       = module.vpc.nat_gateway_public_ips
}

output "alb_dns_name" {
  description = "DNS name of the dev application load balancer."
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "Route 53 zone ID of the dev application load balancer."
  value       = module.alb.alb_zone_id
}

output "alb_security_group_id" {
  description = "Security group ID attached to the dev application load balancer."
  value       = module.alb.security_group_id
}

output "alb_listener_arn" {
  description = "Listener ARN for the dev application load balancer."
  value       = module.alb.listener_arn
}

output "alb_target_group_arn" {
  description = "Target group ARN for the dev application load balancer."
  value       = module.alb.target_group_arn
}

output "ecr_repository_url" {
  description = "ECR repository URL for dev image pushes."
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the dev ECS cluster."
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "Name of the dev ECS service."
  value       = module.ecs.service_name
}

output "ecs_service_security_group_id" {
  description = "Security group ID attached to dev ECS tasks."
  value       = module.ecs.service_security_group_id
}

output "ecs_log_group_name" {
  description = "CloudWatch log group used by the dev ECS service."
  value       = module.ecs.log_group_name
}
