terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "argocd" {
  name = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  namespace = kubernetes_namespace.argocd.metadata[0].name
  version = var.chart_version

  values = [ file("${path.module}/3-values.yaml") ]

  depends_on = [ kubernetes_namespace.argocd ]
}

resource "kubectl_manifest" "argocd_ingress" {
  yaml_body = file("${path.module}/4-ingress.yaml")
  depends_on = [ helm_release.argocd ]
}

resource "kubernetes_secret" "argocd_repo_ssh" {
  metadata {
    name = "argocd-repo-ssh"
    namespace = var.namespace
    labels = {
      "argocd.argoproj.io/secret-type" = "repo-creds"
    }
  }

  data = {
    url = var.repo_url
    sshPrivateKey = filebase64("${path.module}/5-argocd_gitops_key")
  }

  type = "Opaque"

  depends_on = [ helm_release.argocd ]
}