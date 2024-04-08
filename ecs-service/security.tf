# Some of the security group rules below depend on conditionals
# If NAT Gateway, Endpoints are not enabled, many won't be created

resource "aws_security_group" "this" {
  name        = "${local.name_prefix}-${var.container_name}-sg"
  description = "Allow LoadBalancer and VPC Traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${local.name_prefix}-${var.container_name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lbsg" {
  security_group_id = aws_security_group.this.id
 
  referenced_security_group_id = data.aws_security_group.selected.id
 
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "lbsg" {
  security_group_id = aws_security_group.this.id
 
  # referenced_security_group_id = data.aws_security_group.selected.id
 
   cidr_ipv4         = "0.0.0.0/0"
   ip_protocol       = "-1"
}




