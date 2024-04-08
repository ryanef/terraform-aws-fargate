locals {

  service = {

    frontend = {
      assign_public_ip=false
      cluster_id=module.ecs-cluster.cluster_id
      container_name="frontend"
      container_port=3000
      namespace_arn=module.ecs-cluster.namespace_arn
      # UPDATE WITH YOUR ECR REPO
      image = var.frontend_image
      service_name = "frontend"
      subnets = module.vpc.private_subnets
      target_group_arn=module.loadbalancer.tg_arn["frontend"]
      use_endpoints = var.use_endpoints
      use_nat_gateway = var.use_nat_gateway
      vpc_name = var.vpc_name
      vpc_id = module.vpc.vpc_id
    }
    
    backend = {
      assign_public_ip=false
      cluster_id=module.ecs-cluster.cluster_id
      container_name = "backend"
      container_port = 5000
       # UPDATE WITH YOUR ECR REPO
      image = var.backend_image
      namespace_arn=module.ecs-cluster.namespace_arn
      subnets = module.vpc.private_subnets
      service_name = "backend"
      target_group_arn=module.loadbalancer.tg_arn["backend"]
      vpc_name = var.vpc_name
      vpc_id = module.vpc.vpc_id
      use_endpoints = var.use_endpoints
      use_nat_gateway = var.use_nat_gateway
    }
  }

  lb_listener_port = 80
  
  target_group = {

    frontend = {
        deregistration_delay=120
        enabled =     true
        name        = "frontend"
        port        = 80
        protocol    = "HTTP"
        target_type = "ip"
        vpc_id      = module.vpc.vpc_id
        healthy_threshold   = 5
        unhealthy_threshold = 3
        interval            = 45
        timeout             = 25
    }

   backend = {
        deregistration_delay=120
        enabled =    true
        name        = "backend"
        port        = 5000
        protocol    = "HTTP"
        target_type = "ip"
        vpc_id      = module.vpc.vpc_id
        
        healthy_threshold   = 5
        unhealthy_threshold = 3
        interval            = 45
        timeout             = 25
    }   
  }

}

