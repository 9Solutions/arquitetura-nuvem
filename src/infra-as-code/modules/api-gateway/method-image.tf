resource "aws_api_gateway_resource" "image_resource" {
    rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id
    parent_id   = aws_api_gateway_rest_api.api_gateway_rest.root_resource_id
    path_part   = "upload-image"
}

resource "aws_api_gateway_method" "upload_image" {
    rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest.id
    resource_id   = aws_api_gateway_resource.image_resource.id
    http_method   = "POST"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration_upload_image" {
    rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id
    resource_id = aws_api_gateway_resource.image_resource.id
    http_method = aws_api_gateway_method.upload_image.http_method
    integration_http_method = "POST"
    type = "AWS"
    passthrough_behavior = "WHEN_NO_TEMPLATES"
    uri = var.lambda_image_attributes.invoke_arn
}

resource "aws_api_gateway_method_response" "image_response_200" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id
  resource_id = aws_api_gateway_resource.image_resource.id
  http_method = "POST"
  status_code = "200"
}


resource "aws_api_gateway_integration_response" "integration_response_image" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id
  resource_id = aws_api_gateway_resource.image_resource.id
  http_method = "POST"
  status_code = "200"
}

resource "aws_lambda_permission" "lambda_permission_image" {
    statement_id  = "AllowExecutionFromAPIGateway"
    action        = "lambda:InvokeFunction"
    function_name = var.lambda_image_attributes.function_name
    principal     = "apigateway.amazonaws.com"
}