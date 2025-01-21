terraform {
  required_providers {
   azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
}
  backend "azurerm" {
      resource_group_name  = "kml_rg_main-687c378c46c6488e"
      storage_account_name = "pravtest"
      container_name       = "pravcont"
      key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  # Configuration options
  features {}
  skip_provider_registration = true
}
# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "East US"
# }

data "azurerm_resource_group" "example" {
    name = "kml_rg_main-687c378c46c6488e"
  
}
resource "azurerm_storage_account" "example" {
  name                     = "prav212stg"
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "example" {
  name                  = "testestella"
  storage_account_name    = azurerm_storage_account.example.name
  container_access_type = "blob"
}

