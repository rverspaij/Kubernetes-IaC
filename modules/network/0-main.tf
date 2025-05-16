resource "azurerm_virtual_network" "vnet" {
  name = var.vnet_name
  address_space = var.vnet_address_space
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
}

resource "azurerm_subnet" "aks_subnet" {
  name = var.subnet_name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.subnet_prefixes
}