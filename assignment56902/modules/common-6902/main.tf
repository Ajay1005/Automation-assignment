
resource "azurerm_log_analytics_workspace" "n01656902-law" {
  name                = "log-analytics-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  tags = var.resource_tags
}

resource "azurerm_recovery_services_vault" "n01656902-rsv" {
  name                = "recovery-services-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  tags = var.resource_tags
}

resource "azurerm_storage_account" "n01656902-sa" {
  name                     = "n01656902sa"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = var.resource_tags
}

