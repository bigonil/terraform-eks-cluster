# AWS Region
variable "aws_region" {
  description = "AWS region to deploy the EKS cluster"
  type        = string
  default     = "us-east-1"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Private & Public Subnets (Only Declared ONCE)
variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

# EKS Cluster & Node Group Names (Only Declared ONCE)
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-eks-cluster"
}

variable "eks_node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = "eks-node-group"
}

# EC2 Instance Type for Worker Nodes
variable "instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "t3.medium"
}

# Autoscaling Configuration for EKS Nodes
variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

# VPC ID for Security Groups (Used in security.tf)
variable "vpc_id" {
  description = "VPC ID where the EKS cluster is deployed"
  type        = string
}