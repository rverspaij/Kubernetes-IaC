terraform {
  required_version = ">=1.4.0"

  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 3.80.0"
    }
    kubernetes = {
        source = "hashicorp/kubernetes"
        version = ">=2.27.0"
    }
    helm = {
        source = "hashicorp/helm"
        version = ">= 2.13.1"
    }
  }
}

provider "azurerm" {
  features {} 
}

provider "kubernetes" {
  host = azurerm_kubernetes_cluster.k8s.kube_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config[0].cluster_ca_certificate)
}

locals {
  project = "demo"
  environment = "dev"
  location = var.location

  tags = merg({
    project = local.project
    environment = local.environment
    managed_by = "terraform"
  }, var.tags)
}

module "resource_group" {
  source = "./modules/resource_group"
  resource_group_name = "${local.project}-${local.environment}-rg"
  location = local.location
  tags = local.tags
}

module "network" {
  source = "./modules/network"
  vnet_name = "${local.project}-${local.environment}-vnet"
  vnet_address_space = var.vnet_address_space
  subnet_name = "aks-subnet"
  subnet_prefixes = var.subnet_prefixes
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags = local.tags
}