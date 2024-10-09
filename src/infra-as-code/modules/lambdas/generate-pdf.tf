variable "id_account" {
  description = "Id da conta"
  type        = string
  default     = "810673762812"
}

locals {
  role_lambda_arn = "arn:aws:iam::${var.id_account}:role/LabRole"
}

resource "aws_lambda_function" "lambda_generate_pdf" {
  depends_on = [ 
    var.s3_bucket,
    var.s3_object
   ]

  function_name = "generate-pdf"
  role          = local.role_lambda_arn
  runtime       = "nodejs18.x"
  timeout = 90

  s3_bucket = "bucket-caixadesapato"
  s3_key = "dist_pdf.zip"

  handler     = "dist/handler.handler"
  memory_size = 300

  vpc_config {
    subnet_ids         = [var.private_subnet]
    security_group_ids = [var.security_group_ids[2]]
  }
}
