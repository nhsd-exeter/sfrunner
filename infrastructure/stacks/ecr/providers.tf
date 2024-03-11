provider "aws" {
  region  = var.aws_region

  default_tags {
    tags = {
      "Programme"   = "uec"
      "Service"     = "service-finder"
      "Product"     = "sfrunner"
      "Environment" = var.aws_profile
      "tag"         = "uec-sf"
      "uc_name"     = "UECSF"
    }
  }
}