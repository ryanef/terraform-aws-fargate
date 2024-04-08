data "aws_region" "current" {}


data "aws_security_group" "selected" {
 tags = {
   Name = "${local.name_prefix}-public-lb"
 }
}

data "aws_security_group" "default" {
  tags = {
    Name = "${var.vpc_name}-${var.environment}-sg"
  }
 }

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "task_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

