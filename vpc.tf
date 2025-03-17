resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.eks_cluster_name}-vpc"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(["${var.aws_region}a", "${var.aws_region}b"], count.index)

  tags = {
    Name = "${var.eks_cluster_name}-private-${count.index}"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = element(["${var.aws_region}a", "${var.aws_region}b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.eks_cluster_name}-public-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.eks_cluster_name}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Name = "${var.eks_cluster_name}-public-rt"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}