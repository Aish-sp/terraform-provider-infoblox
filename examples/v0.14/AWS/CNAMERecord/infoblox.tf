terraform {
  # Required providers block for Terraform v0.14.7
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    infoblox = {
      source  = "terraform-providers/infoblox"
      version = ">= 1.0"
    }
  }
}

# Create CNAME record for VM
resource "infoblox_cname_record" "ib_cname_record"{
  dns_view = "default"

  canonical = "CanonicalTestName.aws.com"
  alias = "AliasTestName.aws.com"

  ttl = 3600

  comment = "CNAME record created"
  extensible_attributes = jsonencode({
    "Tenant ID" = "tf-plugin"
    "CMP Type" = "Terraform"
    "Cloud API Owned" = "True"
    "Location" = "Test loc."
    "Site" = "Test site"
  })
}
