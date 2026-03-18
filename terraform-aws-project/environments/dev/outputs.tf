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
