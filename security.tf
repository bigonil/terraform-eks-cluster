# 🔹 Security Group for EKS Control Plane
resource "aws_security_group" "eks_control_plane" {
  name_prefix = "${var.eks_cluster_name}-control-plane"
  vpc_id      = var.vpc_id

  # Allow inbound communication from worker nodes
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private_subnets
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.eks_cluster_name}-control-plane-sg"
  }
}

# 🔹 Security Group for Worker Nodes
resource "aws_security_group" "eks_worker_nodes" {
  name_prefix = "${var.eks_cluster_name}-workers"
  vpc_id      = var.vpc_id

  # Allow nodes to communicate with the control plane
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.eks_control_plane.id]
  }

  # Allow worker nodes to communicate within themselves
  ingress {
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = var.private_subnets
  }

  # Allow inbound SSH (Optional, for debugging)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.eks_cluster_name}-workers-sg"
  }
}

# 🔹 Output Security Group IDs
output "eks_security_group_id" {
  description = "Security Group ID for EKS Control Plane"
  value       = aws_security_group.eks_control_plane.id
}

output "eks_worker_nodes_security_group_id" {
  description = "Security Group ID for Worker Nodes"
  value       = aws_security_group.eks_worker_nodes.id
}