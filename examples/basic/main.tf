module "variable-sets" {
  source              = "../../"
  organization        = "hc-gcve"
  create_variable_set = true
  variable_set_name   = "my-set"
  tags                = ["nsx"]
  variables = {
    AWS_REGION = {
      category    = "env"
      description = "(Required) AWS Region where the resources will be instantiated."
      sensitive   = false
      hcl         = false
      value       = "ap-southeast-1"
    },
    aws_tag_owner = {
      category    = "terraform"
      description = "(Required) Owner of all resources that will be created - Use an email address"
      sensitive   = false
      hcl         = false
      value       = "my-email@email.com"
    },
    aws_tag_ttl = {
      category    = "terraform"
      description = "(Required) TTL of the resources that will be provisioned for this demo. Specified in hours"
      sensitive   = false
      hcl         = false
      value       = "8760"
    },
  }
}

# module "variable-sets-update" {
#   source              = "../../"
#   organization        = "hc-gcve"
#   create_variable_set = false
#   variable_set_name   = "my-set"
#   tags                = ["nsx"]
#   variables = {
#     TEST_UPDATE = {
#       category    = "env"
#       description = "(Required) AWS Region where the resources will be instantiated."
#       sensitive   = false
#       hcl         = false
#       value       = "ap-southeast-1"
#     }
#   }
# }
