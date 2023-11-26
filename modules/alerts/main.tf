resource "azurerm_monitor_action_group" "main" {
  name                = "actiongroup-default"
  resource_group_name = var.resource_group_name
  short_name          = "default"

  # webhook_receiver {
  #   name        = "callmyapi"
  #   service_uri = "http://example.com/alert"
  # }

  email_receiver {
    email_address           = var.email_address
    name                    = var.email_name
    use_common_alert_schema = true
  }

  sms_receiver {
    name         = "smsreceiver"
    country_code = var.sms_country_code
    phone_number = var.sms_phone_number
  }
}

resource "azurerm_monitor_metric_alert" "storage" {
  name                = "storage-transactions-metricalert"
  resource_group_name = var.resource_group_name
  scopes              = [var.storage_id]
  description         = "Action will be triggered when Transactions count is greater than ${var.storage_transactions_threshold}."

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Transactions"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.storage_transactions_threshold

    dimension {
      name     = "ApiName"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }
}
