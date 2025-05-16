variable "location" {
  description = "Region in which all Azure resources are made"
  type = string
}

variable "vm_size" {
    description = "The size of the VM's for the AKS nodes"
    type = string
    default = "Standard_D2s_v3"
}

variable "node_count" {
  description = "Amount of nodes per node pool"
  type = number
  default = 1
}

variable "vnet_address_space" {
  description = "CIDR-reach for vnet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "CIDR-reach for subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "tags" {
  description = "General tags for all resources"
  type        = map(string)
  default     = {}
}
