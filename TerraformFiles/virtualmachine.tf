resource "azurerm_public_ip" "ip1" {
  name                = "publicip1"
  location            = azurerm_resource_group.res_group.location
  resource_group_name = azurerm_resource_group.res_group.name
  allocation_method   = "Dynamic" # You can also use "Static" for a static IP

  tags = {
    creator = "prince"
  }
}

resource "azurerm_public_ip" "ip2" {
  name                = "publicip2"
  location            = azurerm_resource_group.res_group.location
  resource_group_name = azurerm_resource_group.res_group.name
  allocation_method   = "Dynamic" # You can also use "Static" for a static IP

  tags = {
    creator = "prince"
  }
}

resource "azurerm_network_interface" "nic1" {
  name                = "uat-nic"
  location            = azurerm_resource_group.res_group.location
  resource_group_name = azurerm_resource_group.res_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip1.id
  }
}

resource "azurerm_network_interface" "nic2" {
  name                = "preprod-nic"
  location            = azurerm_resource_group.res_group.location
  resource_group_name = azurerm_resource_group.res_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.sub1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ip2.id
  }
}

resource "azurerm_linux_virtual_machine" "uatvm" {
  name                = "uat-vm"
  resource_group_name = azurerm_resource_group.res_group.name
  location            = azurerm_resource_group.res_group.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update
apt-get -y install python
apt-get -y install python3-pip
pip install flask
EOF
  )
}

resource "azurerm_linux_virtual_machine" "preprodvm" {
  name                = "preprod-vm"
  resource_group_name = azurerm_resource_group.res_group.name
  location            = azurerm_resource_group.res_group.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic2.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  custom_data = base64encode(<<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get -y install python
sudo apt-get -y install python3-pip
sudo pip install flask
EOF
  )
}