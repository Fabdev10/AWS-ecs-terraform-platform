aws_region = "eu-west-1"

project_name = "aws-ecs-platform"
environment  = "prod"

vpc_cidr = "10.20.0.0/16"

availability_zones = [
  "eu-west-1a",
  "eu-west-1b"
]

public_subnet_cidrs = [
  "10.20.0.0/24",
  "10.20.1.0/24"
]

private_subnet_cidrs = [
  "10.20.10.0/24",
  "10.20.11.0/24"
]

common_tags = {
  Owner       = "platform-team"
  CostCenter  = "production"
  Terraform   = "true"
}

alb_ingress_cidr_blocks = ["0.0.0.0/0"]
alb_listener_port       = 80
app_port                = 3000
health_check_path       = "/health"

alb_enable_deletion_protection = true
