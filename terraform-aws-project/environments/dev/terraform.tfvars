aws_region = "eu-west-1"

project_name = "aws-ecs-platform"
environment  = "dev"

vpc_cidr = "10.10.0.0/16"

availability_zones = [
  "eu-west-1a",
  "eu-west-1b"
]

public_subnet_cidrs = [
  "10.10.0.0/24",
  "10.10.1.0/24"
]

private_subnet_cidrs = [
  "10.10.10.0/24",
  "10.10.11.0/24"
]

common_tags = {
  Owner      = "platform-team"
  CostCenter = "engineering"
  Terraform  = "true"
}

alb_ingress_cidr_blocks = ["0.0.0.0/0"]
alb_listener_port       = 80
app_port                = 3000
health_check_path       = "/health"

alb_enable_deletion_protection = false

ecr_image_tag_mutability = "MUTABLE"
ecr_scan_on_push         = true
ecr_max_image_count      = 20

app_image_tag = "latest"

ecs_cpu                    = 256
ecs_memory                 = 512
ecs_desired_count          = 1
ecs_enable_execute_command = false

app_environment = {
  NODE_ENV = "development"
  PORT     = "3000"
}
