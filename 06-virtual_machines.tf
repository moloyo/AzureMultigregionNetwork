module "master_node" {
  source                = "./master_node"
  id                    = "01"
  rg_name               = azurerm_resource_group.rg.name
  location              = azurerm_virtual_network.east_us.location
  kubeadm_token         = var.kubeadm_token
  network_interface_ids = [azurerm_network_interface.east_us.id]
  username              = var.username
}

module "west_europe_worker_nodes" {
  for_each = var.west_europe_nodes

  source                = "./worker_nodes"
  id                    = each.value
  rg_name               = azurerm_resource_group.rg.name
  location              = azurerm_virtual_network.west_europe.location
  kubeadm_token         = var.kubeadm_token
  network_interface_ids = [azurerm_network_interface.west_europe.id]
  master_ip             = module.master_node.master_private_ip_address
  username              = var.username
}

module "west_us_worker_nodes" {
  for_each = var.west_us_nodes

  source                = "./worker_nodes"
  id                    = each.value
  rg_name               = azurerm_resource_group.rg.name
  location              = azurerm_virtual_network.west_us.location
  kubeadm_token         = var.kubeadm_token
  network_interface_ids = [azurerm_network_interface.west_us.id]
  master_ip             = module.master_node.master_private_ip_address
  username              = var.username
}
