resource "azurerm_resource_group" "RG-Test" {
  for_each = var.storage_map
  name     = each.value.rg_name
  location = each.value.location
}

resource "azurerm_storage_account" "storage-test" {
  for_each = var.storage_map
  name                     = each.value.storage_account_name
  resource_group_name      = each.value.rg_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

dynamic "network_rules" {
    for_each = contains(keys(each.value), "network_rules") ? [each.value.network_rules] : []

    content {
      default_action = network_rules.value.default_action
    }
  }
}
resource "azurerm_storage_container" "container" {
  name                  = "test-blob-container"
  storage_account_name  = azurerm_storage_account.storage-test.name
  container_access_type = "container"
}