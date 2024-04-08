locals {
  # https://docs.aws.amazon.com/AmazonECR/latest/userguide/vpc-endpoints.html#ecr-setting-up-vpc-create
  endpoints = {

    "s3endpoint"={
      dns_record_ip_type=null
      ip_address_type=null
      private_dns_enabled=false
      private_dns_only_for_inbound_resolver_endpoint=null
      route_table_ids=[module.vpc.private_rt]
      subnet_ids=null
      security_group_ids=null
      service_name="com.amazonaws.${data.aws_region.current.id}.s3"
      vpc_endpoint_type="Gateway"
      vpc_id=module.vpc.vpc_id
    }

    "ecrapi"={
      dns_record_ip_type=null
      ip_address_type="ipv4"
      private_dns_enabled=true
      private_dns_only_for_inbound_resolver_endpoint=null
      route_table_ids=null
      subnet_ids=module.vpc.private_subnets
      security_group_ids=[module.vpc.vpc_security_group]
      service_name="com.amazonaws.${data.aws_region.current.id}.ecr.api"
      vpc_endpoint_type="Interface"
      vpc_id=module.vpc.vpc_id
    }

    "ecrdkr"={
      dns_record_ip_type=null
      ip_address_type="ipv4"
      private_dns_enabled=true
      private_dns_only_for_inbound_resolver_endpoint=null
      route_table_ids=null
      subnet_ids=module.vpc.private_subnets
      security_group_ids=[module.vpc.vpc_security_group]
      service_name="com.amazonaws.${data.aws_region.current.id}.ecr.dkr"
      vpc_endpoint_type="Interface"
      vpc_id=module.vpc.vpc_id
    }

    "logs"={
      dns_record_ip_type=null
      ip_address_type="ipv4"
      private_dns_enabled=true
      private_dns_only_for_inbound_resolver_endpoint=null
      route_table_ids=null
      subnet_ids=module.vpc.private_subnets
      security_group_ids=[module.vpc.vpc_security_group]
      service_name="com.amazonaws.${data.aws_region.current.id}.logs"
      vpc_endpoint_type="Interface"
      vpc_id=module.vpc.vpc_id
    }
  }

}