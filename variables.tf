variable "region" {
  default     = "ap-south-1"
  type = string
  description = "AWS region"
}

variable "customer_name" {
  default = "Isbc"
  type = string
  description = "Name of the Customer(Keep it small)"
  validation {
    condition     = length(var.customer_name) > 0 
    error_message = "Customer Name is empty"
  }
}

variable "eks_environment" {
  default = "Qa"
  type = string
  description = "RDS environment - QA/PROD"
}

variable "eks_vpc_cidr" {
  default     = "10.0.0.0/16"
  type = string
  description = "EKS VPC CIDR range"
}

variable "eks_vpc_cidr_private_subnet_1" {
  default     = "10.0.1.0/24"
  type = string
  description = "EKS VPC Private Subnet 1 CIDR range"
}

variable "eks_vpc_cidr_private_subnet_2" {
  default     = "10.0.2.0/24"
  type = string
  description = "EKS VPC Private Subnet 2 CIDR range"
}

variable "eks_vpc_cidr_public_subnet_1" {
  default     = "10.0.3.0/24"
  type = string
  description = "EKS VPC Public Subnet 1 CIDR range"
}

variable "eks_vpc_cidr_public_subnet_2" {
  default     = "10.0.4.0/24"
  type = string
  description = "EKS VPC Public Subnet 2 CIDR range"
}

variable "eks_vpc_az_subnet_1" {
  default     = "ap-south-1a"
  type = string
  description = "EKS VPC Subnet 1 Availability zone"
}

variable "eks_vpc_az_subnet_2" {
  default     = "ap-south-1b"
  type = string
  description = "EKS VPC Subnet 2 Availability zone"
}

variable "nodegroup_one_name" {
  description = "Nodegroup (group one) name to be used"
  type        = string
  default     = "isbc-ui"
}

variable "eks_cluster_version" {
  description = "Version of eks cluster"
  type        = string
  default     = "1.28"
}

variable "registry_server" {
  default     = "https://index.docker.io/v1/"
}

variable "registry_username" {
  default     = "madhubhatpeps"
}

variable "registry_password" {
  default     = "dckr_pat_TzjNwNKhcbULGFiehJBKH2uuO9g"
}

#***************************external secrets

# variable "enabled" {
#   type    = bool
#   default = true
# }

# variable "cluster_name" {
#   type        = string
#   description = "The name of the cluster"
# }

# variable "cluster_identity_oidc_issuer" {
#   type        = string
#   description = "The OIDC Identity issuer for the cluster."
# }

# variable "cluster_identity_oidc_issuer_arn" {
#   type        = string
#   description = "The OIDC Identity issuer ARN for the cluster that can be used to associate IAM roles with a service account."
# }

# variable "helm_chart_name" {
#   type        = string
#   default     = "external-secrets"
#   description = "External Secrets chart name."
# }

# variable "helm_chart_release_name" {
#   type        = string
#   default     = "external-secrets"
#   description = "External Secrets release name."
# }

# variable "helm_chart_repo" {
#   type        = string
#   default     = "https://charts.external-secrets.io"
#   description = "External Secrets repository name."
# }

# variable "helm_chart_version" {
#   type        = string
#   default     = "0.7.1"
#   description = "External Secrets chart version."
# }

# variable "create_namespace" {
#   type        = bool
#   default     = true
#   description = "Whether to create k8s namespace with name defined by `namespace`"
# }

# variable "namespace" {
#   type        = string
#   default     = "external-secrets"
#   description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
# }

# variable "service_account_name" {
#   type        = string
#   default     = "external-secrets"
#   description = "External Secrets service account name"
# }

# variable "mod_dependency" {
#   default     = null
#   description = "Dependence variable binds all AWS resources allocated by this module, dependent modules reference this variable"
# }

# variable "settings" {
#   default     = {}
#   description = "Additional settings which will be passed to the Helm chart values, see https://github.com/external-secrets/external-secrets/tree/main/deploy/charts/external-secrets"
# }