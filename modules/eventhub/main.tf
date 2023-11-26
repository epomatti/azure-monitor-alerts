resource "azurerm_eventhub_namespace" "default" {
  name                = "evhns-${var.workload}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1
}

resource "azurerm_eventhub" "default" {
  name                = "evh-${var.workload}"
  namespace_name      = azurerm_eventhub_namespace.default.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1

  # capture_description {
  #   enabled             = true
  #   encoding            = "Avro"
  #   interval_in_seconds = var.evh_interval_in_seconds
  #   size_limit_in_bytes = var.evh_size_limit_in_bytes

  #   destination {
  #     name                = "EventHubArchive.AzureBlockBlob"
  #     blob_container_name = azurerm_storage_container.events.name
  #     storage_account_id  = azurerm_storage_account.default.id
  #     archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
  #   }
  # }
}
