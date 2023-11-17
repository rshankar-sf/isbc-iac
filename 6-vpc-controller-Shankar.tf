# resource "kubectl_manifest" "service_account" {
#   yaml_body = <<-EOF
# apiVersion: v1
# kind: ServiceAccount
# metadata:
#   labels:
#     k8s-addon: cluster-autoscaler.addons.k8s.io
#     k8s-app: cluster-autoscaler
#   name: cluster-autoscaler
#   namespace: kube-system
#   annotations:
#     eks.amazonaws.com/role-arn: ${module.cluster_autoscaler_irsa_role.iam_role_arn}
# EOF
# }
