variable "variables" {
  type = map(object({
    category    = string
    description = string
    category    = string
    sensitive   = optional(bool)
    hcl         = bool
    value       = any
  }))
}

variable "create_duration" {
  description = "(Optional) - Optional creation duration wait time for the module to execute. Helps eliminate the need for explicit dependecies when creating variable sets and workspaces in the same run"
  type        = string
  default     = "0s"
}

variable "organization" {
  description = "(Required) Name of the TFC Organization where the workspaces reside"
  type        = string
}

variable "create_variable_set" {
  type        = bool
  description = "(Optional) Conditional that will create a variable set for the variables that are being created. Defaults to true"
  default     = true
}

variable "variable_set_name" {
  type        = string
  description = "(Required) Name of the variable set that will be created or used (if create_variable_set is set to false)."
}

variable "variable_set_description" {
  type        = string
  description = "(Optional) Description that will be tied to the variable set if one is being created."
  default     = "Variable Set created via Terraform"
}

variable "tags" {
  type        = list(string)
  description = "(Optional) List of tags that will be used when determining the workspace IDs. Required if create_variable_set is set to true."
  default     = []
}
