# Définition des Variables pour le déploiement du module

# Variable localisation et RG

variable resource_group_name {
  description = "Nom du RG"
  type = string
  default = "dunab13-rg"
}

variable location {
  description = "Localisation des ressources"
  type = string
  default = "francecentral"
}

# Variables ressources

variable vnet_name {
  description = "Nom du Vnet"
  type = string
  default = "dunab13-vnet"
}

variable address_space {
  description = "CIDR"
  type = list(string)
  default = ["10.6.0.0/16"]
}

variable subnet1_name {
  description = "Nom du sous-réseau 1"
  type = string
  default = "dunab13-sbnt"
}

variable subnet1_prefix {  
  description = "Plage d'adresses IP pour le sous-réseau 1"
  type = list(string)
  default = ["10.6.1.0/24"]
}

/* variable gateway_name {  
  description = "Nom de la passerelle"
  type = string
  default = "dunab13_gateway"
}

variable pubIP_gateway_name {  
  description = "Nom de l'IP publique de la gateway"
  type = string
  default = "dunab13_gateway_pubIP"
}

variable pubIP_allocation {  
  description = "Méthode d'allocation pour l'IP publique de la gateway"
  type = string
  default = "Static"
}

variable pubIP_sku {  
  description = "SKU de l'IP publique de la gateway"
  type = string
  default = "Standard"
}

variable priv_subnet_name {  
  description = "Nom du sous-réseau privé"
  type = string
  default = "dunab13_priv_sbnt"
}

variable priv_sbnt_add_pref {  
  description = "Plage d'adresses IP pour le sous-réseau privé"
  type = list(string)
  default = ["10.6.2.0/24"]
} */

variable pub_subnet_name {  
  description = "Nom du sous-réseau publique"
  type = string
  default = "dunab13_pub_sbnt"
}

variable pub_sbnt_add_pref {  
  description = "Plage d'adresses IP pour le sous-réseau publique"
  type = list(string)
  default = ["10.6.3.0/24"]
}

# Variables pour la VM

variable nsg_name {
  description = "Nom du NSG de la VM"
  type = string
  default = "dunab13_nsg"
}

variable nsg-rule_name {
  description = "Nom de la règle NSG de la VM"
  type = string
  default = "nsgRule_allow-ssh"
}

variable nsgRule_priority {
  description = "Priority of the NSG rule allow_ssh"
  type = string
  default = 1001
}

variable nsgRule_direction {
  description = "Direction d'ouverture du port"
  type = string
  default = "Inbound"
}

variable nsgRule_access {
  description = "Autorisation pour la direction d'ouverture du port"
  type = string
  default = "Allow"
}

variable nsgRule_protocol {
  description = "Type de protocole pour la règle allow_ssh"
  type = string
  default = "Tcp"
}

variable nsgRule_source_port_range {
  description = "Port ou plage de ports autorisés ou refusés pour le trafic entrant ou sortant"
  type = string
  default = "*"
}

variable nsgRule_destination_port_range {
  description = "Port de destination à ouvrir"
  type = string
  default = "22"
}

variable nsgRule_source_address_prefix {
  description = "Plage d'adresses IP autorisées à initier le trafic"
  type = string
  default = "*"
}

variable nsgRule_destination_address_prefix {
  description = "Plage d'adresses IP à laquelle le trafic est destiné"
  type = string
  default = "*"
}

variable nsg-rule_name2 {
  description = "Nom de la règle 2 NSG de la VM"
  type = string
  default = "nsgRule_allow-outbound"
}

variable nsgRule_priority2 {
  description = "Priority of the NSG rule allow-outbound"
  type = string
  default = 2001
}

variable nsgRule_direction2 {
  description = "Direction d'ouverture du port"
  type = string
  default = "Outbound"
}

variable nsgRule_access2 {
  description = "Autorisation pour la direction d'ouverture du port"
  type = string
  default = "Allow"
}

variable nsgRule_protocol2 {
  description = "Type de protocole pour la règle allow_ssh"
  type = string
  default = "Tcp"
}

variable nsgRule_source_port_range2 {
  description = "Port ou plage de ports autorisés ou refusés pour le trafic entrant ou sortant"
  type = string
  default = "*"
}

variable nsgRule_destination_port_range2 {
  description = "Port de destination à ouvrir"
  type = string
  default = "*"
}

variable nsgRule_source_address_prefix2 {
  description = "Plage d'adresses IP autorisées à initier le trafic"
  type = string
  default = "*"
}

variable nsgRule_destination_address_prefix2 {
  description = "Plage d'adresses IP à laquelle le trafic est destiné"
  type = string
  default = "*"
}

variable nic_publicIP_name {
  description = "Nom de l'IP publique du NIC de la VM"
  type = string
  default = "dunab13_nic_pubIP"
}

variable nic_pubIP_allocation {
  description = "Méthode d'allocation pour l'IP publique du NIC de la VM"
  type = string
  default = "Static"
}

variable sku_nic_pubIP {
  description = "SKU de l'adresse IP publique du NIC de la VM"
  type = string
  default = "Standard"
}

variable vm_name {
  description = "Nom du cluster AKS"
  type = string
  default = "dunab13-VM"
}

variable vm_size {
  description = "Taille de la VM"
  type = string
  default = "Standard_DS1_v2"
}

variable admin_username {
  description = "Nom de l'administrateur de la VM"
  type = string
  default = "DunaAdmin"
}

variable storage_account_type {
  description = "Type de compte de stockage"
  type = string
  default = "Premium_LRS"
}

variable nic_name {
  description = "Nom du NIC"
  type = string
  default = "dunab13_Nic"
}

variable nicIP_conf {
  description = "Nom de la configuration NIC"
  type = string
  default = "internal"
}

variable nic_allocation {
  description = "Type d'allocation de l'adresse IP privée"
  type = string
  default = "Dynamic"
}