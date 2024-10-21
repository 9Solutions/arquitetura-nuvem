variable "id_account" {
  description = "Id da conta"
  type        = string
  default     = "810673762812"
}

locals {
  role_lambda_arn = "arn:aws:iam::${var.id_account}:role/LabRole"
}

variable "private_subnet" {
    type = string
    description = "Id Subnet"
}

variable "security_group_ids" {
  type = list(string)
  description = "grupos de segurança"
}