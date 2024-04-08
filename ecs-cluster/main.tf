resource "aws_cloudwatch_log_group" "this" {
  name = "${var.vpc_name}-${var.environment}-log"
}

resource "aws_ecs_cluster" "this" {
  name = "${var.vpc_name}-${var.environment}-cluster"

  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.this.arn
  }
}

resource "aws_service_discovery_http_namespace" "this" {
  name        = "${var.vpc_name}-${var.environment}-namespace"
  description = "namespace"
}