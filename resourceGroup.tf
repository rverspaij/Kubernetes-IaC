resource "azurerm_resource_group" "k8s-rg" {
    name = "${var.username}-rg"
    location = var.location
}

output "id" {
    value = "data.azurerm_resource_group.k8s-rg.id"
}