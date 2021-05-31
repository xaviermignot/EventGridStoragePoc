resource "azurerm_role_assignment" "rbac_storage_afa" {
  scope                = azurerm_storage_account.storage_account.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_function_app.afa_app.identity[0].principal_id
}
