resource "azurerm_public_ip" "east_us_ip" {
  name                = "east-us-ip"
  location            = azurerm_virtual_network.east_us.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "west_europe_ip" {
  name                = "west-europe-ip"
  location            = azurerm_virtual_network.west_europe.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "west_us_ip" {
  name                = "west-us-ip"
  location            = azurerm_virtual_network.west_us.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}