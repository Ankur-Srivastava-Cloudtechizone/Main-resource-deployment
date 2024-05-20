vm_map = {
  vm1 = {
    pip_name                  = "pip-vm"
    rg_name                   = "rg-frontend-prod-ci-01"
    location                  = "centralindia"
    allocation_method         = "Static"
    sku                       = "Standard"
    nic_name = "nic-frontend-prod-ci-01"
    ip_config_name            = "nic-frontend-01"
    vm_name                   = "vm-frontend-01"
    vm_size                   = "Standard_DS1_v2"
    vm_username               = "adminuser"
    vm_passwd                 = "admin@123456"
    data_name                 = "frontend-subnet-01"
    data_virtual_network_name = "frontend-vnet"
    data_resource_group_name  = "rg-frontend-prod-ci-01"
  }

  vm2 = {
    pip_name                  = "pip-vm-02"
    rg_name                   = "rg-frontend-prod-ci-01"
    location                  = "centralindia"
    allocation_method         = "Static"
    sku                       = "Standard"
    nic_name = "nic-frontend-prod-ci-02"
    ip_config_name            = "nic-frontend-02"
    vm_name                   = "vm-frontend-02"
    vm_size                   = "Standard_DS1_v2"
    vm_username               = "adminuser"
    vm_passwd                 = "admin@123456"
    data_name                 = "frontend-subnet-01"
    data_virtual_network_name = "frontend-vnet"
    data_resource_group_name  = "rg-frontend-prod-ci-01"
  }

}