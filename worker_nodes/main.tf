resource "azurerm_linux_virtual_machine" "worker" {
  name                  = "worker-${var.location}-${var.id}"
  resource_group_name   = var.rg_name
  location              = var.location
  size                  = "Standard_DS2_v2"
  admin_username        = var.username
  network_interface_ids = var.network_interface_ids

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

  lifecycle {
    ignore_changes = [
      identity
    ]
  }
}

resource "azurerm_virtual_machine_extension" "worker" {
  name                 = "worker-${var.location}-${var.id}-setup"
  virtual_machine_id   = azurerm_linux_virtual_machine.worker.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  protected_settings = <<PROT
    {
        "script": "${base64encode(templatefile("${path.module}/worker-script.sh", { token = var.kubeadm_token, master_ip = var.master_ip }))}"
    }
    PROT
}
