
  lb_map = {
    lb_pip_name       = "pip-lb-01"
    location          = "centralindia"
    rg_name           = "rg-frontend-prod-ci-01"
    lb_name           = "frontend-lb-01"
    frontend_pip_name = "frontend-pip-address-01"
    pip_sku = "Standard"
    lb_sku = "Standard"
    backend_pool_name = "frontend-bkpool-01"
    vnet_name        = "frontend-vnet"
    lb_bkpool-addresses_name-01 = "frontend-bkpool-addresses-01"
    lb_bkpool-addresses_name-02 = "frontend-bkpool-addresses-02"
    data_nic_name-01 = "nic-frontend-prod-ci-01"
    data_nic_name-02 = "nic-frontend-prod-ci-02"
  }
