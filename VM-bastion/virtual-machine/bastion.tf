resource "azurerm_subnet" "bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = "rg-amazon-prod-ci-01"
  virtual_network_name = "amazon-vnet"
  address_prefixes     = ["10.0.11.224/27"]
}

resource "azurerm_public_ip" "azurerm-pip" {
  name                = "pip-vm"
  resource_group_name = "rg-amazon-prod-ci-01"
  location            = "centralindia"
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "examplebastion"
  location            = "centralindia"
  resource_group_name = "rg-amazon-prod-ci-01"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion-subnet.id
    public_ip_address_id = azurerm_public_ip.azurerm-pip.id
  }
}