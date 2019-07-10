provider "azurerm" {
  version = "=1.21.0"
  subscription_id = "${var.subscriptionid}"
  client_id       = "${var.clientid}"
  client_secret   = "${var.clientsecret}"
  tenant_id       = "${var.tenantid}"
}

resource "azurerm_container_registry" "registry" {
  name                = "${var.dockerregistryname}"
  resource_group_name = "${var.resourcegroupname}"
  location            = "${var.location}"
  admin_enabled       = true
  sku                 = "Standard"
  tags                = "${var.tags}"
}

terraform {
  backend "azurerm" {}
}
