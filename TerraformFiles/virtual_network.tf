resource "azurerm_network_security_group" "network-sg" {
  name                = "first-project-security-group"
  location            = azurerm_resource_group.res_group.location
  resource_group_name = azurerm_resource_group.res_group.name
}

resource "azurerm_virtual_network" "network" {
  name                = "first-project-network"
  location            = azurerm_resource_group.res_group.location
  resource_group_name = azurerm_resource_group.res_group.name
  address_space       = ["192.168.0.0/16"]
#   dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "192.168.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "192.168.2.0/24"
    security_group = azurerm_network_security_group.network-sg.id
  }

  tags = {
    creator = "prince"
  }
}