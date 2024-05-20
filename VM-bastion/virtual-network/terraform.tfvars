vnet_map = {
  vnet1 = {
    name          = "amazon-vnet"
    location      = "centralindia"
    rg_name       = "rg-amazon-prod-ci-01"
    address_space = ["10.0.0.0/16"]
  }
  vnet2 = {
    name          = "netflix-vnet"
    location      = "southindia"
    rg_name       = "rg-netflix-prod-ci-02"
    address_space = ["192.168.0.0/16"]
  }
  vnet3 = {
    name          = "ril-vnet"
    location      = "eastus"
    rg_name       = "rg-ril-prod-ci-03"
    address_space = ["172.169.0.0/16"]
  }
}