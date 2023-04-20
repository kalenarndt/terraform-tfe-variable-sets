output "variable_set" {
  value       = var.create_variable_set ? tfe_variable_set.set : data.tfe_variable_set.set
  description = "Output of the Variable Set that has been created or updated"
}

output "variable_set_name" {
  value       = var.create_variable_set ? tfe_variable_set.set[0].name : data.tfe_variable_set.set[0].name
  description = "Output for the name of the variable set that has been created or updated"
}

output "project_variable_set_association" {
  value       = try(tfe_project_variable_set.pset, null)
  description = "Projects that had a variable set associated (if supplied)."
}
