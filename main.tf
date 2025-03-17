# Module for VPC and networking
module "networking" {
  source        = "./modules/vpc"
  vpc_cidr      = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Module for Security Groups
module "security" {
  source         = "./modules/security"
  vpc_id         = module.networking.vpc_id
  private_subnets = module.networking.private_subnets
}

# Module for EKS Cluster & Worker Nodes
module "eks" {
  source            = "./modules/eks"
  cluster_name      = var.eks_cluster_name
  node_group_name   = var.eks_node_group_name
  vpc_id            = module.networking.vpc_id
  private_subnets   = module.networking.private_subnets
  public_subnets    = module.networking.public_subnets
  security_group_id = module.security.eks_security_group_id
  instance_type     = var.instance_type
  desired_capacity  = var.desired_capacity
  min_capacity      = var.min_capacity
  max_capacity      = var.max_capacity
}