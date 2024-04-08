data "aws_region" "current" {}

data "aws_security_group" "frontend" {
  tags = {
    Name = "${var.vpc_name}-${var.environment}-frontend-sg"
  }
  depends_on = [ module.ecs-service ]
}

data "aws_security_group" "backend" {
  tags = {
    Name = "${var.vpc_name}-${var.environment}-backend-sg"
  }
  depends_on = [ module.ecs-service ]
}


