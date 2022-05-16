module "variable-sets" {
  source              = "kalenarndt/variable-sets/tfe"
  version             = ">=0.0.3"
  organization        = "my-org"
  create_variable_set = true
  variable_set_name   = "my-set"
  tags                = ["aws"]
  variables = {
    AWS_REGION = {
      category    = "env"
      description = "(Required) AWS Region where the resources will be instantiated."
      sensitive   = false
      value       = "ap-southeast-1"
    },
    aws_tag_owner = {
      category    = "terraform"
      description = "(Required) Owner of all resources that will be created - Use an email address"
      sensitive   = false
      value       = "my-email@email.com"
    },
    aws_tag_ttl = {
      category    = "terraform"
      description = "(Required) TTL of the resources that will be provisioned for this demo. Specified in hours"
      sensitive   = false
      value       = "8760"
    },
  }
}
