resource "azurerm_network_interface" "network-interface" {
  name                = "nic-amazon-prod-ci-01"
  location            = "centralindia"
  resource_group_name = "rg-amazon-prod-ci-01"

  ip_configuration {
    name                          = "nic-amazon"
    subnet_id                     = "/subscriptions/dcb10fb4-9f27-497e-8dd5-5cae3d81250a/resourceGroups/rg-amazon-prod-ci-01/providers/Microsoft.Network/virtualNetworks/amazon-vnet/subnets/amazon-subnet-01"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "Virtual-machine" {
  name                            = "vm-amazon"
  resource_group_name             = "rg-amazon-prod-ci-01"
  location                        = "centralindia"
  size                            = "Standard_DS1_v2"
  disable_password_authentication = false
  admin_username                  = "adminuser"
  admin_password                  = "admin@123456"
  network_interface_ids = [
    azurerm_network_interface.network-interface.id,
  ]

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

