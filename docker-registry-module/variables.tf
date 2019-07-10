variable "dockerregistryname" {
    type = "string"
}

variable "location" {
    type        = "string"
    description = "location of the resource"
}

variable "tags" {
    type = "map"
}


variable "resourcegroupname" {
    type = "string"
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

variable "tenantid" {
    type ="string"
}
