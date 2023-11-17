terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.58.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
    kubectl = {
      source          = "gavinbunney/kubectl"
      version         = "~> 1.9.1"
    }
    http = {
        source = "hashicorp/http"
        version = "~> 2.1"
      }
  }
}
