vnet = {
  vnet1 = {
    rg_name       = "rg1"
    location      = "centralindia"
    vnet_name     = "vnet1"
    nsg_name      = "nsg1"
    address_space = "10.0.0.0/16"
    subnets = [
      {
        subnet_name    = "subnet1"
        address_prefix = "10.0.1.0/24"
      },
      {
        subnet_name    = "subnet2"
        address_prefix = "10.0.2.0/24"
        security_group = "nsg1"
      }
    ]
} }