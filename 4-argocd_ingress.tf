resource "kubernetes_manifest" "argocd_ingress" {
  manifest = yamldecode(file("${path.module}/manifests/argocd-ingress.yaml"))
  depends_on = [azurerm_kubernetes_cluster.k8s]
}
