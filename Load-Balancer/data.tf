# Retrieve the IP address of the virtual machine
data "azurerm_virtual_network" "data-vnet" {
  name                = var.lb_map.vnet_name
  resource_group_name = var.lb_map.rg_name
}


data "azurerm_network_interface" "data-nic-01" {
  name                = var.lb_map.data_nic_name-01
  resource_group_name = var.lb_map.rg_name
}

data "azurerm_network_interface" "data-nic-02" {
  name                = var.lb_map.data_nic_name-02
  resource_group_name = var.lb_map.rg_name
}
