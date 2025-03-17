# Output the EKS Cluster ID
output "cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.eks.id
}

# Output the EKS Cluster Endpoint
output "cluster_endpoint" {
  description = "EKS Cluster API Endpoint"
  value       = aws_eks_cluster.eks.endpoint
}

# Output the Kubernetes Config Command
output "kubeconfig_command" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --name ${var.eks_cluster_name} --region ${var.aws_region}"
}

# Output Worker Node IAM Role ARN
output "eks_node_role_arn" {
  description = "IAM Role ARN for EKS Worker Nodes"
  value       = aws_iam_role.eks_nodes_role.arn
}

# Output Private Subnets Used for EKS Nodes
output "private_subnets" {
  description = "Private subnets used by the EKS cluster"
  value       = aws_subnet.private[*].id
}

# Output Public Subnets
output "public_subnets" {
  description = "Public subnets used in the EKS cluster"
  value       = aws_subnet.public[*].id
}