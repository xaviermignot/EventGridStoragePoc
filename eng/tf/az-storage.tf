resource "azurerm_storage_account" "storage_account" {
  name                = lower("stor${replace(var.project, "-", "")}")
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  account_replication_type = "LRS"
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "storage_container_raw" {
  name                  = "raw-packages"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "storage_container_signed" {
  name                  = "signed-packages"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}
