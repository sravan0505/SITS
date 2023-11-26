# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}

subscription_id = "6f33b3b0-1a2c-491d-bbf5-f79f2e584ccc"
client_id 	    = "a6b4bc8b-2d88-4d22-a913-dfd916801267"
client_secret 	= "5177c445-edee-46cd-9716-6a780d7a8102"
tenant_id 	    = "18efd9d6-7b18-441a-94f3-243008d6e40a"

}

# Create a resource group
resource "azurerm_resource_group" "sits-rg" {
  name     = "SITS-RG"
  location = "UK South"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "sits-vnet" {
  name                = "SITS-VNET"
  resource_group_name = azurerm_resource_group.sits-rg.name
  location            = azurerm_resource_group.sits-rg.location
  address_space       = ["10.10.0.0/16"]
}

# Create a subnet within the resource group
resource "azurerm_subnet" "sits-subnet" {
  name                 = "SITS-subnet"
  resource_group_name  = azurerm_resource_group.sits-rg.name
  virtual_network_name = azurerm_virtual_network.sits-vnet.name
  address_prefixes     = ["10.10.1.0/24"]

  }