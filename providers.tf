terraform {
  experiments      = [module_variable_optional_attrs]
  required_version = "<=1.2.9"
  required_providers {
    tfe = {
      version = ">=0.30.0"
    }
  }
}
