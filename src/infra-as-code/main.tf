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
  s3_bucket = module.storage.aws_s3_bucket
  s3_object = module.storage.aws_s3_object
}
