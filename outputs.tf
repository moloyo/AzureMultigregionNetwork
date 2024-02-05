output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "master_user" {
  value = var.username
}

output "master_public_ip_address" {
  value = module.master_node.master_public_ip_address
}
