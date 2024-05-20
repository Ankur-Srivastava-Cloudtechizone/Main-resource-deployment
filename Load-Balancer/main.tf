resource "azurerm_public_ip" "lb_pip" {
  name                = var.lb_map.lb_pip_name
  location            = var.lb_map.location
  resource_group_name = var.lb_map.rg_name
  allocation_method   = "Static"
  sku                 = var.lb_map.pip_sku
}

resource "azurerm_lb" "loadbalancer" {
  
  name                = var.lb_map.lb_name
  location            = var.lb_map.location
  resource_group_name = var.lb_map.rg_name
  sku = var.lb_map.lb_sku

  frontend_ip_configuration {
    name                 = var.lb_map.frontend_pip_name
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

# Create a backend pool for the Load Balancer and populate it with VM IPs
resource "azurerm_lb_backend_address_pool" "bkpool-address" {
  
  name                           = var.lb_map.backend_pool_name
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  }

resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
  
  name                    = var.lb_map.lb_bkpool-addresses_name-01
  backend_address_pool_id = azurerm_lb_backend_address_pool.bkpool-address.id
  virtual_network_id      = data.azurerm_virtual_network.data-vnet.id
  ip_address              = data.azurerm_network_interface.data-nic-01.private_ip_address
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  
  name                    = var.lb_map.lb_bkpool-addresses_name-02
  backend_address_pool_id = azurerm_lb_backend_address_pool.bkpool-address.id
  virtual_network_id      = data.azurerm_virtual_network.data-vnet.id
  ip_address              = data.azurerm_network_interface.data-nic-02.private_ip_address
}
  resource "azurerm_lb_probe" "nginxprobe" {
    
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = "http-port"
  port            = 80
  
}
resource "azurerm_lb_rule" "example" {
  
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "NginxRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb_map.frontend_pip_name
  
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bkpool-address.id]
  probe_id                       = azurerm_lb_probe.nginxprobe.id
}