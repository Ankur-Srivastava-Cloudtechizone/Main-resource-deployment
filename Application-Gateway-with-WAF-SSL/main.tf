resource "azurerm_resource_group" "example" {
  name     = var.appgw.appgw_rg_name
  location = var.appgw.appgw_location
}

resource "azurerm_virtual_network" "appgw-vnet" {
  depends_on          = [azurerm_resource_group.example]
  name                = var.appgw.appgw_vnet_name
  resource_group_name = var.appgw.appgw_rg_name
  location            = var.appgw.appgw_location
  address_space       = var.appgw.appgw_address_space
}
resource "azurerm_subnet" "example" {
  depends_on           = [azurerm_virtual_network.appgw-vnet]
  name                 = var.appgw.appgw_subnet_name
  resource_group_name  = var.appgw.appgw_rg_name
  virtual_network_name = azurerm_virtual_network.appgw-vnet.name
  address_prefixes     = var.appgw.appgw_address_prefixes
}

resource "azurerm_public_ip" "example" {
  depends_on          = [azurerm_resource_group.example]
  name                = var.appgw.appgw_pip
  location            = var.appgw.appgw_location
  resource_group_name = var.appgw.appgw_rg_name
  allocation_method   = "Static"
  sku = "Standard"
}


resource "azurerm_application_gateway" "example" {
  depends_on          = [azurerm_resource_group.example]
  name                = var.appgw.appgw_name
  resource_group_name = var.appgw.appgw_rg_name
  location            = var.appgw.appgw_location
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

   # Reference to the WAF policy

  waf_configuration {
    enabled = true
    firewall_mode = "Detection"
    rule_set_version   = "3.1"
    # Replace "YOUR_WAF_POLICY_ID_OR_NAME" with the actual ID or name of your WAF policy
    # custom_rules {
    #   name     = "customRule1"
    #   priority = 1
    #   action   = "Block"

    #   match_conditions {
    #     match_variables = ["RemoteAddr"]
    #     operator        = "IPMatch"
    #     negation        = false
    #     match_values    = ["10.0.0.0/24"]
    #   }
    # }
  }

  gateway_ip_configuration {
    name      = var.appgw.appgw_config_ip_name
    subnet_id = azurerm_subnet.example.id
  }

  ssl_certificate {
    name     = "example-cert"
    data     = filebase64("C:/Users/cloud/Desktop/dabur_wild.pfx")
    password = "PASSWORD"
  }
  

  frontend_ip_configuration {
    name                          = var.appgw.frontend_ip_config_name
    public_ip_address_id          = azurerm_public_ip.example.id
    private_ip_address_allocation = "Dynamic"
  }

  frontend_port {
    name = var.appgw.frontend_port
    port = 443
  }
  backend_http_settings {
    name                  = "example-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
  # http_settings {
  #   name                      = "example-http-settings"
  #   cookie_based_affinity     = "Disabled"
  #   port                      = 80
  #   protocol                  = "Http"
  #   request_timeout           = 20
  # }

  backend_address_pool {
    name = "example-backend-pool"
    # backend_addresses {
    #   fqdn = "backend.azurewebsites.net"
    # }
  }

  http_listener {
    name                           = "example-http-listener"
    frontend_ip_configuration_name = var.appgw.frontend_ip_config_name
    frontend_port_name             = var.appgw.frontend_port
    protocol                       = "Https"
    ssl_certificate_name           = "example-cert"
  }

  request_routing_rule {
    name                       = "example-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "example-http-listener"
    backend_address_pool_name  = "example-backend-pool"
    backend_http_settings_name = "example-backend-http-settings"
    priority                   = 1

    # path_based_rules {
    #   path = "/app1/*"
    #   backend_address_pool_id = azurerm_application_gateway.example.backend_address_pool[0].id
    #   backend_http_settings_id = azurerm_application_gateway.example.backend_http_settings[0].id
    # }
    # path_based_rules {
    #   path = "/app2/*"
    #   backend_address_pool_id = azurerm_application_gateway.example.backend_address_pool[0].id
    #   backend_http_settings_id = azurerm_application_gateway.example.backend_http_settings[0].id
    # }
  }
}

