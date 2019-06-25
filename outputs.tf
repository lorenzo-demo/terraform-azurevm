output "vm_name" {
  value = azurerm_virtual_machine.vm.name
}

output "vm_ip_priv" {
  value = azurerm_network_interface.vm.private_ip_address
}
