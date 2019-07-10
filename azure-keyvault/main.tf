provider "azurerm" {
  version = "=1.21.0"
  subscription_id = "${var.subscriptionid}"
  client_id       = "${var.clientid}"
  client_secret   = "${var.clientsecret}"
  tenant_id       = "${var.tenantid}"
}

locals {
  allowreaders = ["${var.readers}"]
  allowwriters = ["${var.writers}"]
}

data "azurerm_subnet" "subnets" {
  count                = "${length(var.subnet_ids)}"

  name                 = "${element(split(",", element(var.subnet_ids, count.index)),0)}"
  virtual_network_name = "${element(split(",", element(var.subnet_ids, count.index)),1)}"
  resource_group_name  = "${element(split(",", element(var.subnet_ids, count.index)),2)}"
}

resource "azurerm_key_vault" "keyvault" {
  name                            = "${var.keyvaultname}"
  location                        = "${var.location}"
  resource_group_name             = "${var.resourcegroupname}"
  enabled_for_disk_encryption     = true
  tenant_id                       = "${var.tenantid}"
  tags                            = "${var.tags}"

  enabled_for_deployment          = true
  enabled_for_template_deployment = true

  sku {
    name = "standard"
  }

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = "${distinct(cidrlist)}"
    virtual_network_subnet_ids = ["${data.azurerm_subnet.subnets.*.id}"]
  }
}

resource "azurerm_key_vault_access_policy" "readers" {
  count               = "${length(local.allowreaders)}"

  vault_name          = "${azurerm_key_vault.keyvault.name}"
  resource_group_name = "${azurerm_key_vault.keyvault.resource_group_name}"

  tenant_id = "${var.tenantid}"
  object_id = "${element(local.allowreaders, count.index)}"

  certificate_permissions = [
    "get", "list"
  ]

  key_permissions = [
    "get", "list"
  ]

  secret_permissions = [
    "get", "list"
  ]
}

resource "azurerm_key_vault_access_policy" "writers" {
  count               = "${length(local.allowwriters)}"

  vault_name          = "${azurerm_key_vault.keyvault.name}"
  resource_group_name = "${azurerm_key_vault.keyvault.resource_group_name}"

  tenant_id = "${var.tenantid}"
  object_id = "${element(local.allowwriters, count.index)}"

  certificate_permissions = [
    "get", "list", "create", "update"
  ]

  key_permissions = [
    "get", "list", "create", "update"
  ]

  secret_permissions = [
    "get", "list", "set"
  ]
}



terraform {
  backend "azurerm" {}
}
