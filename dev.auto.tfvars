location         = "westeurope"
vm_size          = "Standard_D2s_v3"
node_count       = 1
vnet_address_space = ["10.0.0.0/16"]
subnet_prefixes    = ["10.0.1.0/24"]

tags = {
  owner        = "Raoul Verspaij"
}

subscription_id = "365392ff-b101-4c74-a710-17152ad08a96"
