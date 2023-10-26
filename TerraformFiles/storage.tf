# resource "azurerm_storage_account" "azurestorage" {
#   name                     = "princestorage1997"
#   resource_group_name      = azurerm_resource_group.res_group.name
#   location                 = azurerm_resource_group.res_group.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = {
#     creator = "prince"
#   }
# }

# resource "azurerm_storage_container" "storage_container" {
#   name                  = "tfstate"
#   storage_account_name  = azurerm_storage_account.azurestorage.name
#   container_access_type = "private"
# }