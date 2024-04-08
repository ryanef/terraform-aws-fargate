resource "aws_ecs_task_definition" "this" {
  family = "${local.name_prefix}-${var.container_name}"
  cpu = var.task_cpu
  memory = var.task_memory
  execution_role_arn = aws_iam_role.execution_role.arn
  task_role_arn = aws_iam_role.task_role.arn
  network_mode="awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }
  
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          appProtocol = "http"
          name = var.container_name
        }
      ],
      logConfiguration = {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.this.name}",
          "awslogs-region" : "${data.aws_region.current.id}",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ])

}