resource "aws_api_gateway_resource" "resource" {
  path_part   = var.path_part
  parent_id   = var.parent_id
  rest_api_id = var.api_id
}
