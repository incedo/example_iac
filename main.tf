provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "static_app_rg" {
  name     = "my-static-web-app-rg"
  location = "eastus"
}

resource "azurerm_app_service_plan" "static_app_plan" {
  name                = "my-static-web-app-plan"
  location            = "${azurerm_resource_group.static_app_rg.location}"
  resource_group_name = "${azurerm_resource_group.static_app_rg.name}"
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_storage_account" "static_app_storage" {
  name                     = "mystaticwebappstorage"
  resource_group_name      = "${azurerm_resource_group.static_app_rg.name}"
  location                 = "${azurerm_resource_group.static_app_rg.location}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_static_site" "static_site" {
  name                = "my-static-web-app"
  location            = "${azurerm_resource_group.static_app_rg.location}"
  resource_group_name = "${azurerm_resource_group.static_app_rg.name}"
  app_service_plan_id  = "${azurerm_app_service_plan.static_app_plan.id}"
  repository_url      = "https://github.com/myusername/my-static-web-app"
  branch              = "main"
  app_settings = {
    "WEBSITE_NODE_DEFAULT_VERSION" = "14"
    "WEBSITE_RUN_FROM_PACKAGE"     = "1"
  }
  azure_blob_storage {
    account_name      = "${azurerm_storage_account.static_app_storage.name}"
    container_name    = "$web"
    access_key        = "${azurerm_storage_account.static_app_storage.primary_access_key}"
    cdn_enabled       = true
    cdn_profile_name  = "my-cdn-profile"
    cdn_endpoint_name = "my-cdn-endpoint"
  }
}