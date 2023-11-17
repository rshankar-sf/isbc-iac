locals {
  eks_cluster_version = var.eks_cluster_version
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.15.3"

  cluster_name    = local.cluster_name
  cluster_version = local.eks_cluster_version

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = true
  
  eks_managed_node_groups = {
    isbcui = {
      name = var.nodegroup_one_name
      desired_size = 4
      min_size     = 3
      max_size     = 10

      ami_type = "AL2_ARM_64"

      labels = {
        apptype = var.nodegroup_one_name
      }
      
      instance_types = ["t4g.large"]
      capacity_type  = "ON_DEMAND"  
       
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            volume_size           = 100
            volume_type           = "gp2"
            encrypted             = false
            delete_on_termination = true
          }
        }
      }  
      launch_template_tags = { Name = "${var.nodegroup_one_name}-${local.cluster_name}" }
    }
  }

  tags = {
    Environment = var.eks_environment
    Customer    = var.customer_name
  }
}

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks
  ]
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_name
  depends_on = [
    module.eks
  ]
}
