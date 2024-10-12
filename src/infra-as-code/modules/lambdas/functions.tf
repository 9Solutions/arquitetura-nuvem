resource "aws_lambda_function" "lambda_generate_pdf" {
  function_name = "generate-pdf"
  role          = local.role_lambda_arn
  runtime       = "nodejs18.x"
  handler     = "index.handler"
  timeout = 300
  memory_size = 300

  filename = "index.zip"
}

resource "aws_lambda_function" "lambda_upload_image" {
  function_name = "upload-image"
  role = local.role_lambda_arn
  runtime = "nodejs18.x"
  handler = "index.handler"
  timeout = 30
  memory_size = 128

  filename = "index.zip"
}
