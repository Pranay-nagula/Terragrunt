remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "Terraform"
        storage_account_name = "testterragrunt"
        container_name = "testingcontainer"
    }
}

inputs = {
    location = "westus3"
    resource_group_name = "Terraform"
}

terraform {
  source = ""
}