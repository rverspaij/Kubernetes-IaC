variable "vnet_name" {
    description = "Name of the virtual network"
    type = string
}

variable "vnet_address_space" {
    description = "CIDR-reach for the VNet"
    type = list(string)
}

variable "subnet_name" {
    description = "Name of the subnet for AKS"
    type = string
}

variable "subnet_prefixes" {
  description = "CIDR-reach for the subnet"
  type = list(string)
}

variable "location" {
  description = "Azure region"
  type = string
}

variable "resource_group_name" {
    description = "Name of existing resource group"
    type = string
}

variable "tags" {
    description = "General tags"
    type = map(string)
}