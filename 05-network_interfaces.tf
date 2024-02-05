# East US

data "azurerm_subnet" "east_us_01" {
  name                 = "SharedServicesSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.east_us.name
}

resource "azurerm_network_interface" "east_us" {
  name                = "east-us-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_virtual_network.east_us.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.east_us_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.east_us_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "east_us" {
  network_interface_id      = azurerm_network_interface.east_us.id
  network_security_group_id = azurerm_network_security_group.east_us_nsg.id
}

# West Europe

data "azurerm_subnet" "west_europe_01" {
  name                 = "ManufacturingSystemSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.west_europe.name
}

resource "azurerm_network_interface" "west_europe" {
  name                = "west-europe-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_virtual_network.west_europe.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.west_europe_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.west_europe_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "west_europe" {
  network_interface_id      = azurerm_network_interface.west_europe.id
  network_security_group_id = azurerm_network_security_group.west_europe_nsg.id
}

# Southeast Asia

data "azurerm_subnet" "southeast_asia_01" {
  name                 = "ResearchSystemSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.southeast_asia.name
}

resource "azurerm_network_interface" "southeast_asia" {
  name                = "southeast-asia-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_virtual_network.southeast_asia.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.southeast_asia_01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.southeast_asia_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "southeast_asia" {
  network_interface_id      = azurerm_network_interface.southeast_asia.id
  network_security_group_id = azurerm_network_security_group.southeast_asia_nsg.id
}