variable "assign_public_ip" {
  type = bool
  default = false
}

variable "cluster_id" {
  type = string
}
variable "container_name" {
  type = string
  default = "container"
}

variable "container_cpu" {
  type = number
  default = 512
}

variable "container_memory" {
  type = number
  default = 1024
}

variable "container_port" {
  type = number
  default = 80
}
variable "desired_count" {
  type = number
  default = 1
}

variable "environment" {
  type = string
}

variable "force_new_deployment" {
  default = true
  type = bool
}
variable "image" {
  type = string
}

variable "health_check_grace_period_seconds" {
  default = 90
  type = number
  description = "Seconds to ignore failing load balancer health checks on new tasks"
}

variable "launch_type" {
  type = string
  default = "FARGATE"
}

variable "namespace_arn" {
  type = string
}
variable "service_name" {
  type = string
  default = "ecsservice"
}
variable "subnets" {

}

variable "target_group_arn" {
  type = string
}
variable "task_cpu" {
  type = number
  default = 512
}

variable "task_memory" {
  type = number
  default = 1024
}

variable "use_endpoints" {
  type = bool
  default = false
}

variable "use_nat_gateway"{
  type = bool
  default = false
}
variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  type = string
  
}

