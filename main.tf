# Creation de vm dans Azure
resource "azurerm_resource_group" "vm" {
  name     = "RG-ITFLAB-WE-TerraformpovRG"
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "vm" {
  name                = "TerraformpovNet"
  location            = var.location
  resource_group_name = azurerm_resource_group.vm.name
  address_space       = ["10.0.0.0/16"]

  tags = var.tags
}

resource "azurerm_subnet" "vm" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.vm.name
  virtual_network_name = azurerm_virtual_network.vm.name
  address_prefix       = var.subnet_address_prefix[count.index]
  # "10.0.1.0/24"
}

resource "azurerm_network_interface" "vm" {
  name                = "TerraformpovNetworkInterface0"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

  ip_configuration {
    name                          = "Terraformpovconfiguration0"
    subnet_id                     = azurerm_subnet.vm[0].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "Terraformpov-vm0"
  location              = azurerm_resource_group.vm.location
  resource_group_name   = azurerm_resource_group.vm.name
  network_interface_ids = [azurerm_network_interface.vm.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Terraformpov-vm"
    admin_username = "srvadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.tags
}