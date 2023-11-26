output "eventhub_name" {
  value = azurerm_eventhub.default.name
}

output "eventhub_namespace_name" {
  value = azurerm_eventhub_namespace.default.name
}
