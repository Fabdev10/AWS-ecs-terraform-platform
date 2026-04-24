output "cluster_name" {
  description = "Name of the ECS cluster."
  value       = aws_ecs_cluster.this.name
}

output "cluster_arn" {
  description = "ARN of the ECS cluster."
  value       = aws_ecs_cluster.this.arn
}

output "service_name" {
  description = "Name of the ECS service."
  value       = aws_ecs_service.this.name
}

output "service_arn" {
  description = "ID of the ECS service."
  value       = aws_ecs_service.this.id
}

output "task_definition_arn" {
  description = "ARN of the active ECS task definition."
  value       = aws_ecs_task_definition.this.arn
}

output "service_security_group_id" {
  description = "Security group attached to ECS tasks."
  value       = aws_security_group.service.id
}

output "log_group_name" {
  description = "CloudWatch log group name for the ECS service."
  value       = aws_cloudwatch_log_group.this.name
}
