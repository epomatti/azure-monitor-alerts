terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.81.0"
    }
  }
}

locals {
  workload = "bigfactory"
}

resource "azurerm_resource_group" "default" {
  name     = "rg-${local.workload}"
  location = var.location
}

# module "vnet" {
#   source              = "./modules/vnet"
#   workload            = local.workload
#   resource_group_name = azurerm_resource_group.default.name
#   location            = azurerm_resource_group.default.location
# }

# resource "azurerm_log_analytics_workspace" "default" {
#   name                = "log-${local.workload}"
#   location            = azurerm_resource_group.default.location
#   resource_group_name = azurerm_resource_group.default.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
# }

# module "vm" {
#   source              = "./modules/vm"
#   workload            = local.workload
#   resource_group_name = azurerm_resource_group.default.name
#   location            = azurerm_resource_group.default.location
#   subnet_id           = module.vnet.default_subnet_id
#   size                = var.vm_size
# }

module "storage" {
  source              = "./modules/storage"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

module "eventhub" {
  source              = "./modules/eventhub"
  workload            = local.workload
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
}

module "alerts" {
  source              = "./modules/alerts"
  resource_group_name = azurerm_resource_group.default.name

  storage_id                     = module.storage.storage_id
  storage_transactions_threshold = var.storage_transactions_threshold

  email_address = var.email_address
  email_name    = var.email_name

  sms_country_code = var.sms_country_code
  sms_phone_number = var.sms_phone_number

  event_hub_name      = module.eventhub.eventhub_name
  event_hub_namespace = module.eventhub.eventhub_namespace_name
}
