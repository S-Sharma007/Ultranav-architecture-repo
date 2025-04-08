variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EKS cluster will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the EKS cluster will be created"
  type        = list(string)
}


variable "node_group_name" {
  description = "The name of the EKS node group"
  type        = map(object({
    instance_type = list(string)
    capacity_type = string
    scaling_config = object({
      desired_size  = number
      min_size      = number
      max_size      = number

    })
    ami_type      = string
    key_name      = string

  }))
}
