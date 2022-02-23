
output "resource_group_name" {
  value = azurerm_resource_group.iotStorage.name
}
output "storage_account_name" {
  value = azurerm_storage_account.storagewas.name
}

output "storage_container_name" {
  value = azurerm_storage_container.edge.name
}
