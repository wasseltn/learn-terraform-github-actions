terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.96.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "storew"
    container_name       = "container"
    key                  = "terraform.tfstate"
    resource_group_name  = "Res1"
  }

}

provider "azurerm" {
  features {}


}

resource "azurerm_resource_group" "iotStorage"{
  name="iotStorage"
  location="West Europe"
}


resource "azurerm_storage_account" "storagewass" {
  name                     = "storagewass"
  resource_group_name      = azurerm_resource_group.iotStorage.name
  location                 = azurerm_resource_group.iotStorage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Here we are creating a container in the storage account
resource "azurerm_storage_container" "edge" {
  name                  = "edge"
  storage_account_name  = azurerm_storage_account.storagewass.name
  container_access_type = "private"
}