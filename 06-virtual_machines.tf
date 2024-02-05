resource "azurerm_linux_virtual_machine" "east_us_01" {
  name                = "east-us-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_virtual_network.east_us.location
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.east_us.id,
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
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "west_europe_01" {
  name                = "west-europe-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_virtual_network.west_europe.location
  size                = "Standard_DS2_v2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.west_europe.id,
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
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}