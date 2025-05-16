resource "helm_release" "ingress_nginx" {
  name = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  namespace = "ingress-nginx"
  create_namespace = true

  set {
    name = "controller.publishService.enabled"
    value = true
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }

  depends_on = [ azurerm_kubernetes_cluster.k8s ]
}