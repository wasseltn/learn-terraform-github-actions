# Project variables
variable "location" {
  type = string
  description = "The location for the deployment"
  default = "westeurope"
}

variable "rgname" {
  type        = string
  description = "RG name in Azure"
  default = "iotStorage"
}


variable "saname" {
  type = string
  description = "Storage Account name"
  default = "storagewas"
}
