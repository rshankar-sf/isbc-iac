provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "${var.customer_name}-${var.eks_environment}-Cluster-VPC"
  cidr = "${var.eks_vpc_cidr}"

  azs             = ["${var.eks_vpc_az_subnet_1}", "${var.eks_vpc_az_subnet_2}"]
  private_subnets = ["${var.eks_vpc_cidr_private_subnet_1}", "${var.eks_vpc_cidr_private_subnet_2}"]
  public_subnets  = ["${var.eks_vpc_cidr_public_subnet_1}", "${var.eks_vpc_cidr_public_subnet_2}"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  #map_public_ip_on_launch = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Environment = "${var.eks_environment}"
    Customer = "${var.customer_name}"
  }
  
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.customer_name}-${var.eks_environment}-Cluster" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.customer_name}-${var.eks_environment}-Cluster" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}