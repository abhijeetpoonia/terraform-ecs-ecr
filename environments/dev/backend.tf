terraform {
  backend "s3" {
    bucket         = "dev-state-bucket-matterlab"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}