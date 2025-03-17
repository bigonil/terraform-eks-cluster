output "eks_cluster_endpoint" {
  description = "Kubernetes Cluster API Endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}