resource "azurerm_eventgrid_system_topic" "egtop_storage" {
  name                = "egtop-${var.project}-storage"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  source_arm_resource_id = azurerm_storage_account.storage_account.id
  topic_type             = "Microsoft.Storage.StorageAccounts"
}

resource "azurerm_eventgrid_system_topic_event_subscription" "egsub_storage_raw" {
  name                = "egsub-${var.project}-storage-raw"
  resource_group_name = azurerm_resource_group.rg.name

  system_topic = azurerm_eventgrid_system_topic.egtop_storage.name

  included_event_types = ["Microsoft.Storage.BlobCreated"]

  subject_filter {
    subject_begins_with = "/blobServices/default/containers/${azurerm_storage_container.storage_container_raw.name}"
  }

  azure_function_endpoint {
    function_id = "${azurerm_function_app.afa_app.id}/functions/PackageSigningFunction"
    max_events_per_batch = 1
    preferred_batch_size_in_kilobytes = 64
  }
}
