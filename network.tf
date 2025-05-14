resource "azurerm_virtual_network" "k8s-vnet" {
    name = "${var.username}-vnet"
    location = azurerm_resource_group.k8s-rg.location
    resource_group_name = azurerm_resource_group.k8s-rg.name
    address_space = [ "10.0.0.0/16" ]

    tags = {
        environment = var.tag
    }
}

resource "azurerm_subnet" "k8s-sub01" {
    name = "${var.username}-sub01"
    resource_group_name = azurerm_resource_group.k8s-rg.name
    virtual_network_name = azurerm_virtual_network.k8s-vnet.name
    address_prefixes = [ "10.0.1.0/24" ]
}