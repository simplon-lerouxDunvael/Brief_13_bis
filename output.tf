# Necessayr outputs for the module and the deployment of the main.tf

output "resource_group" {
  value = azurerm_resource_group.rg
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "subnet" {
  value = azurerm_subnet.subnet1
}

output "priv_subnet" {
  value = azurerm_subnet.priv_subnet
}

output "nsg" {
  value = azurerm_network_security_group.nsg
}