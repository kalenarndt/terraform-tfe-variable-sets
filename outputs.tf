output "variable_set" {
  value       = var.create_variable_set ? tfe_variable_set.set : data.tfe_variable_set.set
  description = "Output of the Variable Set that has been created or updated"
}
