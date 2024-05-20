subnet_map = {
  subnet1 = {
    name             = "amazon-subnet-01"
    rg_name          = "rg-amazon-prod-ci-01"
    vnet_name        = "amazon-vnet"
    address_prefixes = ["10.0.1.0/24"]
  }
  subnet2 = {
    name             = "amazon-subnet-02"
    rg_name          = "rg-amazon-prod-ci-01"
    vnet_name        = "amazon-vnet"
    address_prefixes = ["10.0.2.0/24"]
  }
  subnet3 = {
    name             = "netflix-subnet-01"
    rg_name          = "rg-netflix-prod-ci-02"
    vnet_name        = "netflix-vnet"
    address_prefixes = ["192.168.1.0/24"]
  }
  subnet4 = {
    name             = "netflix-subnet-02"
    rg_name          = "rg-netflix-prod-ci-02"
    vnet_name        = "netflix-vnet"
    address_prefixes = ["192.168.2.0/24"]
  }
  subnet5 = {
    name             = "ril-subnet-01"
    rg_name          = "rg-ril-prod-ci-03"
    vnet_name        = "ril-vnet"
    address_prefixes = ["172.169.1.0/24"]
  }
  subnet6 = {
    name             = "ril-subnet-02"
    rg_name          = "rg-ril-prod-ci-03"
    vnet_name        = "ril-vnet"
    address_prefixes = ["172.169.2.0/24"]
  }
}

