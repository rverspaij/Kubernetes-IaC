variable "username" {
    description = "Name of the Azure Resource Group"
    type = string
}

variable "location" {
    description = "Azure region for the resource group"
    type = string
    default = "westeurope"
}

variable "tag" {
    description = "Tag which is give to resources"
    type = string
}