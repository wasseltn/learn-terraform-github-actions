# this terraform script creates an Azure resource groupe and associate a Storage Account to a Blob container
<hr>

# main.tf:


### Defining the terraform version and source 

```terraform


terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.96.0"
    }
  }
```  
### Remote backend state file config
```terraform

  backend "azurerm" {
    storage_account_name = "storew"
    container_name       = "container"
    key                  = "terraform.tfstate"
    resource_group_name  = "Res1"
  }
}


``` 
### Defining the resource group to be created
```terraform


resource "azurerm_resource_group" "iotStorage"{
  name="iotStorage"
  location="West Europe"

}
```

### Creating a storage account in azure
```terraform
resource "azurerm_storage_account" "storagewas" {
  name                     = "storagewas"
  resource_group_name      = azurerm_resource_group.iotStorage.name
  location                 = azurerm_resource_group.iotStorage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}


``` 
### Creating a container in the storage account

```terraform
resource "azurerm_storage_container" "edge" {
  name                  = "edge"
  storage_account_name  = azurerm_storage_account.storagewas.name
  container_access_type = "private"
}


``` 


<hr>

# Script.sh:

### this script create the resource groupe, storage account and blob container for the remote backend state file
```bash
#!/bin/bash

RESOURCE_GROUP_NAME=tfstate
STORAGE_ACCOUNT_NAME=tfstate$RANDOM
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

``` 
