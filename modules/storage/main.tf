resource "random_string" "random" {
  length  = 14
  special = false
  upper   = false
}

resource "azurerm_storage_account" "default" {
  name                     = "st${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
