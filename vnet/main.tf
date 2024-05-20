resource "azurerm_resource_group" "example" {
  for_each = var.vnet
  name     = each.value.rg_name
  location = each.value.location
}

resource "azurerm_network_security_group" "example" {
  depends_on          = [azurerm_resource_group.example]
  for_each            = var.vnet
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
}

resource "azurerm_virtual_network" "example" {
  depends_on          = [azurerm_network_security_group.example]
  for_each            = var.vnet
  name                = each.value.vnet_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  address_space       = [each.value.address_space]

  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name           = subnet.value.subnet_name
      address_prefix = subnet.value.address_prefix
      security_group = contains(keys(subnet.value), "security_group") ? azurerm_network_security_group.example[each.key].id : null
    }
  }
}