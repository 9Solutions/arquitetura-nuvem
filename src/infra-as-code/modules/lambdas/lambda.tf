variable "id_account" {
  description = "Id da conta"
  type        = string
  default     = "713258500354"
}

locals {
  role_lambda_arn = "arn:aws:iam::${var.id_account}:role/LabRole"
}

resource "aws_lambda_layer_version" "dependencias" {
  filename   = "dependencias.zip"
  layer_name = "app_config"

  compatible_runtimes = ["nodejs18.x"]
}

resource "aws_lambda_function" "lambda_pdf_generate" {
  function_name = "pdf-generate"
  role          = local.role_lambda_arn
  runtime       = "nodejs18.x"

  filename    = "pdf_generate.zip"
  handler     = "src/app.js"
  memory_size = 256

  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.sg_access_api_rest.id]
  }

  layers = [aws_lambda_layer_version.dependencias.arn]
}
