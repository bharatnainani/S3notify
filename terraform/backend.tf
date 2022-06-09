terraform {
  backend "s3" {
    encrypt         = true
    bucket          = ""
    key             = "cloudtrail/terraform.tfstate"
    dynamodb_table  = ""
  }
}
