

data "tfe_organization" "org" {
  name = var.organization
}

data "tfe_project" "proj" {
  for_each     = toset(var.project_names)
  name         = each.value
  organization = data.tfe_organization.org.name
}

data "tfe_workspace_ids" "ws" {
  count        = var.create_variable_set ? 1 : 0
  tag_names    = var.tags
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "var" {
  for_each        = var.variables
  key             = each.key
  value           = each.value.hcl ? replace(jsonencode(each.value.value), "/\"(\\w+?)\":/", "$1=") : try(tostring(each.value.value), null)
  category        = each.value.category
  hcl             = each.value.hcl
  variable_set_id = var.create_variable_set ? tfe_variable_set.set[0].id : data.tfe_variable_set.set[0].id
  description     = each.value.description
  sensitive       = each.value.sensitive
}

resource "tfe_variable_set" "set" {
  count        = var.create_variable_set ? 1 : 0
  name         = var.variable_set_name
  global       = var.global
  description  = var.variable_set_description
  organization = data.tfe_organization.org.name
}

resource "tfe_workspace_variable_set" "set" {
  for_each        = { for k, v in try(data.tfe_workspace_ids.ws[0].ids, []) : k => v if var.create_variable_set == true } # using this for now but needs to also support var.create_variable_set
  variable_set_id = tfe_variable_set.set[0].id
  workspace_id    = each.value
}

resource "tfe_project_variable_set" "pset" {
  for_each        = length(var.project_names) >= 1 ? data.tfe_project.proj : {}
  variable_set_id = var.create_variable_set ? tfe_variable_set.set[0].id : data.tfe_variable_set.set[0].id
  project_id      = each.value.id
}

data "tfe_variable_set" "set" {
  count        = var.create_variable_set ? 0 : 1
  name         = var.variable_set_name
  organization = data.tfe_organization.org.name
}
