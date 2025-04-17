output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_version" {
  description = "The version of the EKS cluster"
  value       = module.eks.cluster_version
}

output "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "cluster_role_arn" {
  description = "The ARN of the IAM role associated with the EKS cluster"
  value       = module.eks.cluster_role_arn
}

output "vpc_id" {
  description = "The ID of the VPC where the EKS cluster is created"
  value       = module.vpc.vpc_id
}