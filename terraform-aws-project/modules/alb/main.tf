locals {
	alb_name          = substr("${var.name}-alb", 0, 32)
	target_group_name = substr("${var.name}-tg", 0, 32)
}

resource "aws_security_group" "this" {
	name        = "${var.name}-alb-sg"
	description = "Security group for the shared application load balancer."
	vpc_id      = var.vpc_id

	ingress {
		description = "HTTP ingress to the load balancer."
		from_port   = var.listener_port
		to_port     = var.listener_port
		protocol    = "tcp"
		cidr_blocks = var.ingress_cidr_blocks
	}

	egress {
		description = "Allow the load balancer to reach downstream targets."
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

	tags = merge(var.tags, {
		Name = "${var.name}-alb-sg"
	})
}

resource "aws_lb" "this" {
	name                       = local.alb_name
	internal                   = var.internal
	load_balancer_type         = "application"
	security_groups            = [aws_security_group.this.id]
	subnets                    = var.subnet_ids
	enable_deletion_protection = var.enable_deletion_protection

	tags = merge(var.tags, {
		Name = local.alb_name
	})
}

resource "aws_lb_target_group" "this" {
	name        = local.target_group_name
	port        = var.target_port
	protocol    = "HTTP"
	target_type = "ip"
	vpc_id      = var.vpc_id

	health_check {
		enabled             = true
		healthy_threshold   = 2
		unhealthy_threshold = 2
		interval            = 30
		timeout             = 5
		matcher             = "200-399"
		path                = var.health_check_path
		port                = "traffic-port"
		protocol            = "HTTP"
	}

	tags = merge(var.tags, {
		Name = local.target_group_name
	})
}

resource "aws_lb_listener" "http" {
	load_balancer_arn = aws_lb.this.arn
	port              = var.listener_port
	protocol          = "HTTP"

	default_action {
		type             = "forward"
		target_group_arn = aws_lb_target_group.this.arn
	}
}
