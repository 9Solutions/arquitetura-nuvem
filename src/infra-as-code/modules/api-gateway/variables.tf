variable "lambda_pdf_attributes" {
  type = object({
    invoke_arn = string
    function_name = string 
  })
}

variable "lambda_image_attributes" {
  type = object({
    invoke_arn = string
    function_name = string 
  })
}