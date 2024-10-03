resource "aws_api_gateway_rest_api" "api_gateway_rest" {
  name               = "api-gateway-caixadesapato"
  binary_media_types = ["image/jpg", "image/jpeg", "image/png", "application/octet-stream"]

  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = [aws_vpc_endpoint.vpc_endpoint.id]
  }

}


data "aws_iam_policy_document" "role_gateway" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = [aws_api_gateway_rest_api.api_gateway_rest.arn]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = ["10.0.0.0/24"]
    }
  }
}

resource "aws_api_gateway_rest_api_policy" "iam_gateway" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id
  policy      = data.aws_iam_policy_document.role_gateway.json
}


# /pdf-generate
resource "aws_api_gateway_resource" "recurso_pdf" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id
  parent_id   = aws_api_gateway_rest_api.api_gateway_rest.root_resource_id
  path_part   = "pdf-generate"
}

resource "aws_api_gateway_method" "pdf_post" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest.id
  resource_id   = aws_api_gateway_resource.recurso_pdf.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "pdf_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway_rest.id
  resource_id             = aws_api_gateway_resource.recurso_pdf.id
  http_method             = aws_api_gateway_method.pdf_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_pdf_generate.invoke_arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_pdf_generate.function_name
  principal     = "apigateway.amazonaws.com"
}



resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway_rest.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.recurso_pdf.id,
      aws_api_gateway_method.pdf_post.id,
      aws_api_gateway_integration.pdf_integration.id
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway_rest.id
  stage_name    = "teste"
}
