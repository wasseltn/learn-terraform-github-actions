#!/bin/bash
#Connect and set Subscription Context in Azure
az login


#Set Variables for Storage account and Key Vault that support the Terraform implementation
RESOURCE_GROUP_NAME=Res1
STORAGE_ACCOUNT_NAME=storew
CONTAINER_NAME=container
STATE_FILE="terraform.state"

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location "West Europe"

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key 
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

# Show details 
echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
echo "state_file: $STATE_FILE"

#
~                      
