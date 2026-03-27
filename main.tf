# AFT Account Request
# Each module block below represents an AWS account to be provisioned.
# Push changes to this repo to trigger account creation/updates.

module "demo_account" {
  source = "./modules/aft-account-request"

  control_tower_parameters = {
    AccountEmail              = "vindexinvestmentsolutions+demo1@gmail.com"
    AccountName               = "AFT-Demo-Account-01"
    ManagedOrganizationalUnit = "Sandbox"
    SSOUserEmail              = "vindexinvestmentsolutions@gmail.com"
    SSOUserFirstName          = "John"
    SSOUserLastName           = "Nguyen"
  }

  account_tags = {
    Environment = "demo"
    ManagedBy   = "AFT"
    Owner       = "jvnstudio"
  }

  account_customizations_name = "demo"

  change_management_parameters = {
    change_requested_by = "John Nguyen"
    change_reason       = "AFT Demo - initial account provisioning"
  }
}
