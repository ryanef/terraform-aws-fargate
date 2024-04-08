output "cluster_id"{
  value = aws_ecs_cluster.this.id
}

output "namespace_arn" {
  value = aws_service_discovery_http_namespace.this.arn
}