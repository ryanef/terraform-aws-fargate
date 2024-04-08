variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "use_endpoints" {
  type = bool
  default = false
}

variable "use_nat_gateway" {
  type = bool
  default = false
}

variable "vpc_name" {
  type = string
  default = "ecs-vpc"
}

### IMAGES ###
### REFERENCED IN LOCALS.TF FILE ###
variable "frontend_image" {
  default = ""
  type = string
  description = "ECR Repository URI, example:590133767612.dkr.ecr.us-east-1.amazonaws.com/reactdevtest"
}
variable "backend_image" {
  default = ""
  type = string
   description = "ECR Repository URI, example:590133767612.dkr.ecr.us-east-1.amazonaws.com/reactdevtest"
}

### NETWORKING ###
variable "vpc_cidr" {
  default = "10.10.0.0/20"
  type = string
}
variable "count_public_cidrs" {
  default = [ "10.10.1.0/25", "10.10.3.0/25" ]
  type = list(string)
  description = "See README for list of default subnet possibilities"
}
variable "count_private_cidrs" {
  default = [ "10.10.2.0/25", "10.10.4.0/25" ]
  type = list(string)
    description = "See README for list of default subnet possibilities"
}