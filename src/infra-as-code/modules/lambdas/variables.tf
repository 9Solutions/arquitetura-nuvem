variable "private_subnet" {
    type = string
    description = "Id Subnet"
}

variable "security_group_ids" {
  type = list(string)
  description = "grupos de segurança"
}

variable "s3_bucket" {
    type = string
    description = "bucket"
}

variable "s3_object" {
  type = string
  description = "dist pdf"
}