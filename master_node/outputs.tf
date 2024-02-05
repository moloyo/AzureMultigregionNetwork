output "master_private_ip_address" {
  value = azurerm_linux_virtual_machine.master.private_ip_address
}

output "master_public_ip_address" {
  value = azurerm_linux_virtual_machine.master.public_ip_address
}