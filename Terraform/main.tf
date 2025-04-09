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
  region = "ap-southeast-2"
}

module "VPC" {

  source = "./module/VPC"

  vpc_cidr              = var.vpc_cidr
  availability_zones    = var.availability_zones
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  cluster_name          = var.cluster_name
  vpc_name              = var.vpc_name
  vpc_tags              = var.vpc_tags
  log_format            = var.log_format
  account_id            = var.account_id

}

module "eks" {
  source ="./module/EKS"

  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
    vpc_id = module.VPC.vpc_id
    subnet_ids = module.VPC.private_subnet_ids
    node_group_name = var.node_group_name
}