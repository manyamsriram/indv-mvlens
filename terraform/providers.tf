provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 0.14"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.1"
    }
  }
}
terraform {
    backend "s3" {
        bucket = "movielensdatasource"
        #dynamodb_table = "terraform-state-lock-db"
        key = "secure-ingest-tf/terraform-state/tfstate.json"
        region = "us-east-2"
    }
}