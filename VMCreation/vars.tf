variable "environment" {
  default = "dev"
}
variable "osdisk_size" {
  default = 30
  type    = number
}

variable "is_delete" {
  type        = bool
  description = "delete disk when deleting vm"
  default     = true

}

variable "rg_name" {
  default = "kml_rg_main-9018bc710f7d4d3f"
}

variable "allowed_locations" {
  type        = list(string)
  description = "list of allowed locations"
  default     = ["West US", "North Europe", "East US"]

}

variable "resource_tags" {
  type        = map(string)
  description = "tags to apply to resources"
  default = {
    "environment" = "dev"
    "managed_by"  = "terraform"
    "department"  = "devops"
  }
}

variable "network_config" {
  type        = tuple([string, string, number])
  description = "vnet address, subnet address"
  default     = ["10.0.0.0/16", "10.0.2.0", 24]

}

variable "allowed_vm_sizes" {
  type        = list(string)
  description = "Allowed VM sizes"
  default     = ["Standard_DS1_v2", "Standard_DS2_v2", "Standard_DS3_v2"]
}


variable "vm_config" {
  type = object({
    size      = string
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "VM config vaules"
  default = {
    size      = "Standard_DS1_v2"
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}