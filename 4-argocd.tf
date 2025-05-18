data "azurerm_kubernetes_cluster" "this" {
    name = "${local.project}-${local.environment}-aks"
    resource_group_name = "${local.project}-${local.environment}-rg"

    depends_on = [ azurerm_kubernetes_cluster.k8s ]
}

resource "helm_release" "argocd" {
  name = "argocd"

  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  namespace = "argocd"
  create_namespace = true
  
  values = [file("values/argocd.yaml")]
}

