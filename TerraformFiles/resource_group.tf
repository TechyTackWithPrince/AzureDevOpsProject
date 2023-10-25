resource "azurerm_resource_group" "res_group" {
  name     = "first_project"
  location = "EAST US"
  tags = {
    creator = "prince"
  }
}