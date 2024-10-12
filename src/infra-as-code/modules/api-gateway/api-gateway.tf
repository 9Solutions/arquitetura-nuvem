resource "aws_api_gateway_rest_api" "api_gateway_rest" {
  name               = "api-gateway-caixadesapato"
  binary_media_types = ["application/pdf", "application/octet-stream"]

  endpoint_configuration {
    types            = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  depends_on = [ 
    aws_api_gateway_integration.integration_lambda_pdf,
    aws_api_gateway_integration.integration_upload_image
  ]

  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest.id
  stage_name    = "live"
}
