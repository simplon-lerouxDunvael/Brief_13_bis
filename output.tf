output "resource_group" {
  value = azurerm_resource_group.rg
}

output "subnet" {
  value = azurerm_subnet.subnet1
}

output "priv_subnet" {
  value = azurerm_subnet.priv_subnet
}

output "nsg" {
  value = azurerm_subnet.nsg
}