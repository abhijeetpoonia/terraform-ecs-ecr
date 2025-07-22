terraform {
  backend "s3" {
    bucket         = "prod-state-bucket"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock-prod"
    encrypt        = true
  }
}