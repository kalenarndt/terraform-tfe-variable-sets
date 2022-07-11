resource "time_sleep" "create" {
  create_duration = var.create_duration
  # This is only here because of a race condition with using this module
  # within a stemcell / control workspace setup in TFC
  # This executes and waits for the workspaces to be present (if specified)
  # Then the data lookup takes place to find the workspace IDs.
}

data "tfe_organization" "org" {
  name       = var.organization
  depends_on = [time_sleep.create]
}

data "tfe_workspace_ids" "ws" {
  count        = var.create_variable_set ? 1 : 0
  tag_names    = var.tags
  organization = data.tfe_organization.org.name
  depends_on   = [time_sleep.create]
}

resource "tfe_variable" "var" {
  for_each        = var.variables
  key             = each.key
  value           = each.value.hcl ? replace(jsonencode(each.value.value), "/\"(\\w+?)\":/", "$1=") : each.value.value
  category        = each.value.category
  hcl             = each.value.hcl
  variable_set_id = var.create_variable_set ? tfe_variable_set.set[0].id : data.tfe_variable_set.set[0].id
  description     = each.value.description
  sensitive       = each.value.sensitive
}

resource "tfe_variable_set" "set" {
  count        = var.create_variable_set ? 1 : 0
  name         = var.variable_set_name
  description  = var.variable_set_description
  organization = data.tfe_organization.org.name
}

resource "tfe_workspace_variable_set" "set" {
  for_each        = data.tfe_workspace_ids.ws[0].ids
  variable_set_id = var.create_variable_set ? tfe_variable_set.set[0].id : data.tfe_variable_set.set[0].id
  workspace_id    = each.value
}

data "tfe_variable_set" "set" {
  count        = var.create_variable_set ? 0 : 1
  name         = var.variable_set_name
  organization = data.tfe_organization.org.name
}
