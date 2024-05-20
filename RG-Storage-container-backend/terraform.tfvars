storage_map = {
  st1 = {
    rg_name                  = "rg-test-nonprod-ci-01"
    location                 = "Central India"
    storage_account_name     = "storagetestnetweb1"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    network_rules = {
      default_action = "Allow"
    }

  }

    st2 = {
    rg_name                  = "rg-test-nonprod-ci-01"
    location                 = "Central India"
    storage_account_name     = "storagetestnetweb12"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

  st3 = {
    rg_name                  = "rg-test-nonprod-ci-01"
    location                 = "Central India"
    storage_account_name     = "storagetestnetweb123"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    network_rules = {
      default_action = "Deny"
    }
}
}   



