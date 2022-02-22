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

  subscription_id = "47bb1c58-ee41-477f-9ba8-ef0d878cfb29"
  client_id       = "ad928e69-8ddb-435e-97ee-bf890e02039d"
  client_secret   = "dqW4dgQ7b8Sx6zWCx8rWJkNz7qw6IU~5Tn"
  tenant_id       = "77e30fb9-ddb4-4a65-a17c-96d895261ec5"

  
}

resource "azurerm_resource_group" "iotStorage"{
  name="iotStorage"
  location="West Europe"
}


resource "azurerm_storage_account" "storagewas" {
  name                     = "storagewas"
  resource_group_name      = azurerm_resource_group.iotStorage.name
  location                 = azurerm_resource_group.iotStorage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Here we are creating a container in the storage account
resource "azurerm_storage_container" "edge" {
  name                  = "edge"
  storage_account_name  = azurerm_storage_account.storagewas.name
  container_access_type = "private"
}