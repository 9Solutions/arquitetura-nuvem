terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "storage" {
  source = "./modules/storage"
}

module "lambdas" {
  source = "./modules/lambdas"

  private_subnet = module.vpc.private_subnet
  security_group_ids = module.vpc.security_group_ids
}

module "api_gateway_rest" {
  source = "./modules/api-gateway"

  lambda_pdf_attributes = module.lambdas.lambda_generate_pdf
  lambda_image_attributes = module.lambdas.lambda_upload_image
}

module "instances" {
  source = "./modules/instances"

  public_subnet_1 = module.vpc.public_subnets[0]
  public_subnet_2 = module.vpc.public_subnets[1]
  private_subnet = module.vpc.private_subnet
  security_group_webserver = module.vpc.security_group_ids[0]
  security_group_api = module.vpc.security_group_ids[1]
  vpc_id = module.vpc.vpc
}
