module "ecs-cluster" {
  source = "./ecs-cluster"
  environment = var.environment
  vpc_name = var.vpc_name
  depends_on = [ module.vpc ]
}

module "ecs-service" {
  source = "./ecs-service"
 
  for_each = local.service
 
  cluster_id = each.value.cluster_id
  container_name = each.value.container_name
  container_port = each.value.container_port
  environment = var.environment
  image=each.value.image
  namespace_arn = each.value.namespace_arn
  subnets = each.value.subnets
  target_group_arn = each.value.target_group_arn
  use_endpoints = each.value.use_endpoints
  use_nat_gateway = each.value.use_nat_gateway
  vpc_name = each.value.vpc_name
  vpc_id = each.value.vpc_id

  depends_on = [ aws_lb_listener.lb_listener ]
}