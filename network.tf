module "vpc" {
  source  = "ryanef/vpc/aws"
  version = "1.3.0"

  count_public_cidrs = var.count_public_cidrs
  count_private_cidrs = var.count_private_cidrs

  enable_dns_hostnames = true
  enable_dns_support=true
  
  environment = var.environment

  use_endpoints = var.use_endpoints
  use_nat_gateway = var.use_nat_gateway

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  vpc_endpoint = var.use_endpoints  ? local.endpoints : null

}

module "loadbalancer" {
  source  = "ryanef/loadbalancer/aws"
  version = "1.1.8"

  environment = var.environment
  vpc_id = module.vpc.vpc_id
  vpc_name = var.vpc_name
  public_subnets = module.vpc.public_subnets
  target_group = local.target_group
}

resource "aws_lb_listener" "lb_listener" {
 
  load_balancer_arn = module.loadbalancer.lb_arn
  port              = local.lb_listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = module.loadbalancer.tg_arn["frontend"]
  }
}

resource "aws_lb_listener_rule" "api" {
  listener_arn = aws_lb_listener.lb_listener.arn
  priority     = 1
 
  action {
    type             = "forward"
    target_group_arn = module.loadbalancer.tg_arn["backend"]
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }

}


