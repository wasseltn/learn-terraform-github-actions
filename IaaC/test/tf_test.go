package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/azure"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformAzureResourceGroupExample(t *testing.T) {
	t.Parallel()

	subscriptionID := ""
	terraformOptions := &terraform.Options{
		TerraformDir: "../",
		Vars:         map[string]interface{}{},
	}
	//clean up any resources
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	//get the values of output variables
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	// Verify the resource group exists
	exists := azure.ResourceGroupExists(t, resourceGroupName, subscriptionID)
	assert.True(t, exists, "Resource group does not exist")
	storageAccountName := terraform.Output(t, terraformOptions, "storage_account_name")
	// Verify the rstorage account exists
	exists1 := azure.StorageAccountExists(t, storageAccountName, resourceGroupName, subscriptionID)
	assert.True(t, exists1, "storage account  does not exist")

	StorageBlobContainerName := terraform.Output(t, terraformOptions, "storage_container_name")
	// Verify the blob container exists
	exists2 := azure.StorageBlobContainerExists(t, StorageBlobContainerName, storageAccountName, resourceGroupName, subscriptionID)
	assert.True(t, exists2, "storage account  does not exist")
}
