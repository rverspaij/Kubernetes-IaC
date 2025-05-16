resource "azurerm_kubernetes_cluster" "k8s" {
  name = "${local.project}-${local.environment}-aks"
  location = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix = "${local.project}-${local.environment}"

  kubernetes_version = null
  sku_tier = "Free"

  default_node_pool {
    name = "default"
    vm_size = var.vm_size
    node_count = var.node_count
    vnet_subnet_id = module.network.subnet_id
    type = "VirtualMachineScaleSets"
    auto_scaling_enabled = true
    min_count = 1
    max_count = 3

    node_labels = {
        role = "default"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    dns_service_ip = "10.0.2.10"
    service_cidr = "10.0.2.0/24"
  }

  oidc_issuer_enabled = true
  workload_identity_enabled = true

  role_based_access_control_enabled = true
  private_cluster_enabled = false

  tags = local.tags

  lifecycle {
    ignore_changes = [ default_node_pool[0].node_count ]
  }

  depends_on = [ module.network ]
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.k8s.kube_config[0].host
  sensitive = true
}