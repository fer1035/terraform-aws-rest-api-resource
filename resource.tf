resource "aws_api_gateway_resource" "resource" {
  path_part   = var.path_part
  parent_id   = var.parent_id
  rest_api_id = var.api_id
}

resource "aws_api_gateway_method" "options" {
  rest_api_id      = var.api_id
  resource_id      = aws_api_gateway_resource.resource.id
  http_method      = "OPTIONS"
  authorization    = "NONE"
  api_key_required = false
  depends_on = [
    aws_api_gateway_resource.resource
  ]
}
resource "aws_api_gateway_method_response" "options" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.options.http_method
  status_code = "200"
  depends_on = [
    aws_api_gateway_method.options
  ]
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}
resource "aws_api_gateway_integration" "options" {
  rest_api_id          = var.api_id
  resource_id          = aws_api_gateway_resource.resource.id
  http_method          = "OPTIONS"
  type                 = "MOCK"
  passthrough_behavior = "WHEN_NO_MATCH"
  depends_on = [
    aws_api_gateway_resource.resource
  ]
  #   # Transforms the incoming XML request to JSON
  #   request_templates = {
  #     "application/xml" = <<EOF
  # {
  #    "body" : $input.json('$')
  # }
  # EOF
  #   }
  request_templates = {
    "application/json" : "{\"statusCode\": 200}"
  }
}
resource "aws_api_gateway_integration_response" "options" {
  rest_api_id = var.api_id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_integration.options.http_method
  status_code = "200"
  depends_on = [
    aws_api_gateway_integration.options
  ]
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'${var.cors}'"
  }
  #   # Transforms the backend JSON response to XML
  #   response_templates = {
  #     "application/xml" = <<EOF
  # #set($inputRoot = $input.path('$'))
  # <?xml version="1.0" encoding="UTF-8"?>
  # <message>
  #     $inputRoot.body
  # </message>
  # EOF
  #   }
}
