variable "keyvaultname" {
  type        = "string"
  description = "Name of keyvault"
}

variable "location" {
  type        = "string"
  description = "Location of keyvault"
}

variable "tenantid" {
  type        = "string"
  description = "Tenant id of directory used to auth"
}

variable "readers" {
  type    = "list"
  default = []
}

variable "writers" {
  type    = "list"
  default = []
}


variable "cidrlist" {
  type    = "list"
  default = []
}


variable subnet_ids {
  type = "list"
  description = "list of csv items <subnetname>,<vnetname>,<resourcegroup>"
  default = []
}

variable "securityeventhubname" {
  type = "string"
  default = ""
}


variable "tags" {
    type = "map"
}

variable "resourcegroupname" {
  type        = "string"
  description = "Name of resource group"
}

variable "subscriptionid" {
    type ="string"
}

variable "clientid" {
    type ="string"
}

variable "clientsecret" {
    type ="string"
}
