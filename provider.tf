terraform {
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
      }
    }
    required_version = ">=1.5.0"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

provider "kubernetes" {
  host = azurerm_kubernetes_cluster.k8s-kube.kube_config[0].host
  client_certificate = base64decode(azurerm_kubernetes_cluster.k8s-kube.kube_config[0].client_certificate)
  client_key = base64decode(azurerm_kubernetes_cluster.k8s-kube.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s-kube.kube_config[0].cluster_ca_certificate)
  
}