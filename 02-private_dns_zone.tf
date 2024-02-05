resource "azurerm_private_dns_zone" "zone" {
  name                = "private.contoso.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "east_us_link" {
  name                  = "CoreServicesVnetLink"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.zone.name
  virtual_network_id    = azurerm_virtual_network.east_us.id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "west_europe_link" {
  name                  = "ManufacturingVnetLink"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.zone.name
  virtual_network_id    = azurerm_virtual_network.west_europe.id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "southeast_asia_link" {
  name                  = "ResearchVnetLink"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.zone.name
  virtual_network_id    = azurerm_virtual_network.southeast_asia.id
  registration_enabled  = true
}