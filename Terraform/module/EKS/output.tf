output "cluster_endpoint" {
  description = "value of the cluster endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  description = "value of the cluster name"
  value       = aws_eks_cluster.main.name
}

output "cluster_version" {
  description = "value of the cluster version"
  value       = aws_eks_cluster.main.version
}       

output "cluster_security_group_id" {
  description = "value of the cluster security group id"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "cluster_role_arn" {
  description = "The ARN of the IAM role associated with the EKS cluster"
  value       = aws_eks_cluster.main.role_arn
}