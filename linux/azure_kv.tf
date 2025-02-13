data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
  name                       = "pravtestkv"
  location                   = data.azurerm_resource_group.example.location
  resource_group_name        = data.azurerm_resource_group.example.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
 object_id = data.azurerm_client_config.current.object_id
    key_permissions    = var.key_permissions
    secret_permissions = var.secret_permissions
  }
}

resource "azurerm_key_vault_secret" "privatekey" {
  name         = "VM-login-private-key"
  value        = tls_private_key.example_ssh.private_key_pem
  key_vault_id = azurerm_key_vault.vault.id
}

# resource "azurerm_key_vault_secret" "pubkey" {
#   name         = "VM-login-pub-key"
#   value        = tls_private_key.example_ssh.public_key_openssh
#   key_vault_id = azurerm_key_vault.vault.id
# }
