terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

resource "kubectl_manifest" "argocd_bootstrap" {
  yaml_body = templatefile("${path.module}/2-application.yaml", {
    app_name      = var.app_name
    namespace     = var.namespace
    repo_url      = var.repo_url
    repo_path     = var.repo_path
    repo_revision = var.repo_revision
  })
}
