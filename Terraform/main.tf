terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "spring-petclinic-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "spring-petclinic-terraform-lock-table"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source     = "./module/VPC"
  vpc_name   = var.vpc_name
  vpc_cidr   = var.vpc_cidr
  account_id = data.aws_caller_identity.current.account_id
  vpc_tags   = {
    Environment = var.environment
    Project     = "petclinic"
  }
}

module "eks" {
  source       = "./module/EKS"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  depends_on   = [module.vpc]
}

data "aws_caller_identity" "current" {}