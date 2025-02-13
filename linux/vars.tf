variable "resource_group_location" {
  type        = string
  default     = "westus"
  description = "Location of the resource group."
}


variable "resource_group_name" {
  type        = string
  default     = "kml_rg_main-92f40548c1a649d2"
  description = "Resource group name in your Azure subscription."
}

variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default     = ["List", "Create", "Delete", "Get", "Purge", "Recover", "Update", "GetRotationPolicy", "SetRotationPolicy"]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default     = ["List", "Delete", "Get", "Set", "Backup"]
}
