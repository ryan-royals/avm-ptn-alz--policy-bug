
terraform {
  required_version = "~> 1.7"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.0"
    }
    alz = {
      source  = "azure/alz"
      version = "~> 0.16"
    }
  }
  backend "local" {
  }
}
variable "subscription_id" {
  type = string
}
provider "azapi" {
  subscription_id = var.subscription_id
}
provider "alz" {
  library_references = [
    {
      custom_url = "${path.root}/alz-library"
    }
  ]
}
data "azapi_client_config" "current" {}

module "alz_architecture" {
  source             = "Azure/avm-ptn-alz/azurerm"
  version            = "0.10.0"
  architecture_name  = "org"
  parent_resource_id = data.azapi_client_config.current.tenant_id
  location           = "australiaEast"
}
