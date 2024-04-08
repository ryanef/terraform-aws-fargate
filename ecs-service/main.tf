locals {
  name_prefix = "${var.vpc_name}-${var.environment}"
}

resource "aws_ecs_service" "this" {
  name            = "${var.container_name}"
  cluster         = var.cluster_id
  force_new_deployment = var.force_new_deployment
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type = var.launch_type

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets=var.subnets
    security_groups = [aws_security_group.this.id]
    assign_public_ip = var.assign_public_ip
  }

  tags = {
    Name = "${local.name_prefix}-${var.service_name}"
  }

  service_connect_configuration {
    enabled = true
    namespace = var.namespace_arn
    
    service {

      discovery_name = var.container_name
      port_name = var.container_name

      client_alias {
        dns_name = var.container_name
        port = var.container_port
      }
    }
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${local.name_prefix}-${var.container_name}"

  tags = {
    Environment = "${local.name_prefix}-${var.container_name}"

  }

}