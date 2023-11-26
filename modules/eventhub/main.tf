resource "azurerm_eventhub_namespace" "default" {
  name                = "evhns-${var.workload}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"
  capacity            = 1
}

resource "azurerm_eventhub" "default" {
  name                = "evh-${var.workload}"
  namespace_name      = azurerm_eventhub_namespace.default.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}
