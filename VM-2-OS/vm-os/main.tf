resource "azurerm_public_ip" "azurerm-pip" {
  for_each            = var.vm_map
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_network_interface" "network-interface" {
  for_each            = var.vm_map
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  

  ip_configuration {
    name                          = each.value.ip_config_name
    subnet_id                     = data.azurerm_subnet.datasubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    
    public_ip_address_id          = azurerm_public_ip.azurerm-pip[each.key].id 
  }
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  for_each            = var.vm_map
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                = each.value.vm_size
  disable_password_authentication = false
  admin_username      = each.value.vm_username
  admin_password      = each.value.vm_passwd

  network_interface_ids = [
    azurerm_network_interface.network-interface[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }
}
