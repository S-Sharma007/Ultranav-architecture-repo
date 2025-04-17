variable "aws_region" {
    description = "AWS region to deploy the VPC"
    type        = string
}

variable "vpc_name" {
    description = "AWS name of the VPC"
    type        = string
}

variable "name" {
    description = "Name prefix for resources"
    type        = string
    default     = "petclinic"
}

variable "vpc_tags" {
    description = "Tags to apply to the VPC"
    type        = map(string)
    default     = {}
}

variable "log_format" {
    description = "Log format for flow logs"
    type        = string
    default     = "$${version} $${account-id} $${interface-id}"
}

variable "account_id" {
    description = "AWS account ID"
    type        = string
}

variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type        = string
}

variable "availability_zones" {
    description = "List of availability zones to use for subnets"
    type        = list(string)
}

variable "private_subnets" {
    description = "List of private subnet CIDR blocks"
    type        = list(string)
}

variable "public_subnets" {
    description = "List of public subnet CIDR blocks"
    type        = list(string)
}

variable "cluster_name" {
    description = "Name of the EKS cluster"
    type        = string
}