output "vpc_id" {
  description = "ID of the shared VPC for downstream modules."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Ordered public subnet IDs aligned to the availability_zones input."
  value       = [for az in var.availability_zones : aws_subnet.public[az].id]
}

output "private_subnet_ids" {
  description = "Ordered private subnet IDs aligned to the availability_zones input."
  value       = [for az in var.availability_zones : aws_subnet.private[az].id]
}

output "public_route_table_id" {
  description = "Route table used by all public subnets."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Private route tables keyed by availability zone."
  value       = { for az in var.availability_zones : az => aws_route_table.private[az].id }
}

output "internet_gateway_id" {
  description = "Internet Gateway attached to the VPC."
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs keyed by availability zone."
  value       = { for az in var.availability_zones : az => aws_nat_gateway.this[az].id }
}

output "nat_gateway_public_ips" {
  description = "Public IPs for NAT gateways, useful for later egress allow-listing if required."
  value       = { for az in var.availability_zones : az => aws_eip.nat[az].public_ip }
}

output "availability_zones" {
  description = "Availability zones used by the VPC."
  value       = var.availability_zones
}
