variable "password" {}
variable "username" {}
variable "nsxhost" {}

terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
    nsxt = {
      source  = "vmware/nsxt"
      version = ">= 3.1.1"
    }
  }

  backend "remote" {
    organization = "netmemo"

    workspaces {
      prefix = "netmemo-"
    }
  }
}

#First variable is from auto.tfvars, username and password from terraform cloud variables
provider "nsxt" {
    host = "${var.nsxhost}"
    username = var.username 
    password = var.password
    allow_unverified_ssl = true
}

resource "nsxt_policy_tier1_gateway" "tier1_gw" {
  description               = "Tier-1 provisioned by Terraform"
  display_name              = "T1-TFC"
  route_advertisement_types = ["TIER1_CONNECTED"]
}

resource "nsxt_policy_tier1_gateway" "tier2_gw" {
  description               = "Tier-1 provisioned by Terraform"
  display_name              = "T2-TFC"
  route_advertisement_types = ["TIER1_CONNECTED"]
}
