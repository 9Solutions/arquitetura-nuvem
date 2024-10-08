variable "id_account" {
  description = "Id da conta"
  type        = string
  default     = "810673762812"
}

locals {
  role_lambda_arn = "arn:aws:iam::${var.id_account}:role/LabRole"
}

resource "aws_lambda_function" "lambda_generate_pdf" {
  function_name = "generate-pdf"
  role          = local.role_lambda_arn
  runtime       = "nodejs18.x"

  handler     = "dist/handler.handler"
  memory_size = 300

  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.sg_gateway_lambda.id]
  }
}
