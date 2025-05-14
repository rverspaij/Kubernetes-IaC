resource "azurerm_kubernetes_cluster" "k8s-kube" {
    name = "${var.username}-k8s"
    location = "westeurope"
    resource_group_name = azurerm_resource_group.k8s-rg.name
    dns_prefix = "dns-aks1"

    default_node_pool {
      name = "default"
      node_count = 1
      vm_size = "Standard_B2s"
      vnet_subnet_id = azurerm_subnet.k8s-sub01.id
    }

    network_profile {
      network_plugin = "azure"
      service_cidr = "10.100.0.0/16"
      dns_service_ip = "10.100.0.10"
      docker_bridge_cidr = "172.17.0.1/16"
    }

    identity {
      type = "SystemAssigned"
    }

    tags = {
      environment = var.tag
    }
}

output "client_certificate" {
    value = azurerm_kubernetes_cluster.k8s-kube.kube_config[0].client_certificate
    sensitive = true
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.k8s-kube.kube_config_raw
    sensitive = true
}