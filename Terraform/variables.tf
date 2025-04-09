variable "aws_region" {
    description = "AWS region to deploy the VPC"
    type        = string
    default ="ap-southeast-2"
  
}

variable "environment" {
    description = "Environment name"
    type        = string
    default ="dev"
}

variable "vpc_name" {
    description = "AWS name of the VPC"
    type        = string
    default ="spring-petclinic-vpc"
}

variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}