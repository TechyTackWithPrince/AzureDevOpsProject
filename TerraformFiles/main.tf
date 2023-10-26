terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.77.0"
    }
  # }
  # backend "azurerm" {
  #   resource_group_name  = "first_project"
  #   storage_account_name = "princestorage99999"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}