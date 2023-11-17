module "ebs_csi_irsa_role" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name             = "${module.eks.cluster_name}-ebs-csi"
  attach_ebs_csi_policy = true

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }
}


resource "aws_eks_addon" "aws-ebs-csi-driver" {
  cluster_name                = module.eks.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.19.0-eksbuild.2"
  service_account_role_arn    = module.ebs_csi_irsa_role.iam_role_arn
  resolve_conflicts_on_update = "PRESERVE"
}