# resource "kubernetes_secret" "isbc-docker-cfg" {
#   metadata {
#     name = "epsusllc-docker-cfg"
#   }

#   type = "kubernetes.io/dockerconfigjson"

#   data = {
#     ".dockerconfigjson" = jsonencode({
#       auths = {
#         "${var.registry_server}" = {
#           "username" = var.registry_username
#           "password" = var.registry_password
#           "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
#         }
#       }
#     })
#   }
  
#   depends_on = [
#     module.eks
#   ]
# }