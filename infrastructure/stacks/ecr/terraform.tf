terraform {
  required_version = ">= 0.13"  # Ensure you specify an appropriate Terraform version.

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.74.1"
    }
  }

  backend "s3" {
  }

}