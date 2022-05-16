data "tfe_organization" "org" {
  name = var.organization
}

data "tfe_workspace_ids" "ws" {
  count        = var.create_variable_set ? 1 : 0
  tag_names    = var.tags
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "var" {
  for_each        = var.variables
  key             = each.key
  value           = each.value.value
  category        = each.value.category
  variable_set_id = var.create_variable_set ? tfe_variable_set.set[0].id : data.tfe_variable_set.set[0].id
  description     = each.value.description
  sensitive       = each.value.sensitive
}

resource "tfe_variable_set" "set" {
  count         = var.create_variable_set ? 1 : 0
  name          = var.variable_set_name
  description   = var.variable_set_description
  organization  = data.tfe_organization.org.name
  workspace_ids = values(data.tfe_workspace_ids.ws[0].ids)
}

data "tfe_variable_set" "set" {
  count        = var.create_variable_set ? 0 : 1
  name         = var.variable_set_name
  organization = data.tfe_organization.org.name
}


