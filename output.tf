output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "subnet_id" {
  value = azurerm_subnet.subnet1.id
}

output "priv_subnet_id" {
  value = azurerm_subnet.priv_subnet.id
}

output "pub_subnet_id" {
  value = azurerm_subnet.pub_subnet.id
}