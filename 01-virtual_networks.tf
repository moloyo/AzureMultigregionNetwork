resource "azurerm_virtual_network" "east_us" {
  name                = "CoreServicesVnet"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.20.0.0/16"]
  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.20.0.0/27"
  }

  subnet {
    name           = "SharedServicesSubnet"
    address_prefix = "10.20.10.0/24"
  }

  subnet {
    name           = "DatabaseSubnet"
    address_prefix = "10.20.20.0/24"
  }

  subnet {
    name           = "PublicWebServiceSubnet"
    address_prefix = "10.20.30.0/24"
  }

  tags = {
    environment = "Development"
  }
}

resource "azurerm_virtual_network" "west_europe" {
  name                = "ManufacturingVnet"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.30.0.0/16"]

  subnet {
    name           = "ManufacturingSystemSubnet"
    address_prefix = "10.30.10.0/24"
  }

  subnet {
    name           = "SensorSubnet1"
    address_prefix = "10.30.20.0/24"
  }

  subnet {
    name           = "SensorSubnet2"
    address_prefix = "10.30.21.0/24"
  }

  subnet {
    name           = "SensorSubnet3"
    address_prefix = "10.30.22.0/24"
  }

  tags = {
    environment = "Development"
  }
}

resource "azurerm_virtual_network" "southeast_asia" {
  name                = "ResearchVnet"
  location            = "Southeast Asia"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.40.0.0/16"]

  subnet {
    name           = "ResearchSystemSubnet"
    address_prefix = "10.40.0.0/24"
  }

  tags = {
    environment = "Development"
  }
}

resource "azurerm_virtual_network_peering" "east_us-west_europe" {
  name                      = "eastus-westeurope"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.east_us.name
  remote_virtual_network_id = azurerm_virtual_network.west_europe.id
  allow_forwarded_traffic   = true
}

resource "azurerm_virtual_network_peering" "east_us-southeast_asia" {
  name                      = "eastus-southeastasia"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.east_us.name
  remote_virtual_network_id = azurerm_virtual_network.southeast_asia.id
}

resource "azurerm_virtual_network_peering" "west_europe-east_us" {
  name                      = "westeurope-eastus"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.west_europe.name
  remote_virtual_network_id = azurerm_virtual_network.east_us.id
}

resource "azurerm_virtual_network_peering" "west_europe-southeast_asia" {
  name                      = "westeurope-southeastasia"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.west_europe.name
  remote_virtual_network_id = azurerm_virtual_network.southeast_asia.id
}

resource "azurerm_virtual_network_peering" "southeast_asia-east_us" {
  name                      = "southeastasia-eastus"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.southeast_asia.name
  remote_virtual_network_id = azurerm_virtual_network.east_us.id
}

resource "azurerm_virtual_network_peering" "southeast_asia-west_europe" {
  name                      = "southeastasia-westeurope"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.southeast_asia.name
  remote_virtual_network_id = azurerm_virtual_network.west_europe.id
}

