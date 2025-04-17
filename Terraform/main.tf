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

data "aws_caller_identity" "current" {}

module "vpc" {
  source              = "./module/VPC"
  name                = var.vpc_name
  vpc_name            = var.vpc_name
  vpc_cidr            = var.vpc_cidr
  account_id          = data.aws_caller_identity.current.account_id
  aws_region          = var.aws_region
  private_subnets     = var.private_subnets_cidr
  public_subnets      = var.public_subnets_cidr
  availability_zones  = var.availability_zones
  cluster_name        = var.cluster_name
  vpc_tags = {
    Environment = var.environment
    Project     = "petclinic"
  }
}

module "eks" {
  source          = "./module/EKS"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  node_group_name = var.node_group_name
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  depends_on      = [module.vpc]
}