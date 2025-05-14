resource "azurerm_resource_group" "k8s-rg" {
    name = var.rg-name
    location = var.location
}