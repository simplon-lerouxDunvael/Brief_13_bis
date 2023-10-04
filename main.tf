# Module de déploiement d'un RG, réseau et sous-réseau et d'un cluster AKS => https://github.com/edalferes/terraform-azure-aks/blob/master/variables.tf

terraform {
 required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet1_prefix
}

# BONUS

# Créer une NAT Gateway
resource "azurerm_nat_gateway" "gateway" {
  name                    = var.gateway_name
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
}

# Créer une IP publique pour la NAT Gateway
resource "azurerm_public_ip" "pubIP_gateway" {
  name                = var.pubIP_gateway_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.pubIP_allocation
  sku                 = var.pubIP_sku
}

# Créer un sous-réseau privé
resource "azurerm_subnet" "priv_subnet" {
  name                 = var.priv_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.priv_sbnt_add_pref
}

# Créer un sous-réseau public
resource "azurerm_subnet" "pub_subnet" {
  name                 = var.pub_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.pub_sbnt_add_pref
}


# Créez une clé SSH pour la machine virtuelle
resource "tls_private_key" "sshKey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Créer une adresse IP publique pour le NIC de la VM
resource "azurerm_public_ip" "nic_public_ip" {
  name                = var.nic_publicIP_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.nic_pubIP_allocation # Use "Static" if a static IP is needed
  sku                 = var.sku_nic_pubIP
}

# Créer un NSG pour ouvrir le port 22 de la VM
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Créer les règles du NSG de la VM
resource "azurerm_network_security_rule" "ssh_rule" {
  name                        = var.nsg-rule_name
  priority                    = var.nsgRule_priority
  direction                   = var.nsgRule_direction
  access                      = var.nsgRule_access
  protocol                    = var.nsgRule_protocol
  source_port_range           = var.nsgRule_source_port_range
  destination_port_range      = var.nsgRule_destination_port_range
  source_address_prefix       = var.nsgRule_source_address_prefix
  destination_address_prefix  = var.nsgRule_destination_address_prefix
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Associate security group with network interface
resource "azurerm_network_interface_security_group_association" "nsgAssociation" {
  network_interface_id      = azurerm_network_interface.Nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Créez la machine virtuelle Azure
resource "azurerm_linux_virtual_machine" "VM" {
  name                = var.vm_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.Nic.id]
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.sshKey.public_key_openssh # file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    storage_account_type = var.storage_account_type
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8-LVM"
    version   = "8.8.2023081717"
  }
  /* provisioner "local-exec" {
  command = "ansible-galaxy install -r requirements.yml"
  } */
  /* provisioner "local-exec" {
  command = "ansible-playbook playbook.yml -i inventory.ini"
  } */
}

# Créez une interface réseau pour la machine virtuelle
resource "azurerm_network_interface" "Nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = var.nicIP_conf
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = var.nic_allocation
    public_ip_address_id          = azurerm_public_ip.nic_public_ip.id
  }
}