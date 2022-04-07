output "resource_id" {
  value       = aws_api_gateway_resource.resource.id
  description = "REST API resource ID."
}

output "resource_path" {
  value       = aws_api_gateway_resource.resource.path
  description = "REST API resource path."
}
