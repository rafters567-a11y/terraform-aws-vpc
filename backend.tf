terraform {
  backend "s3" {
    bucket         = "tfstate-678201911571-ap-south-1"
    key            = "vpc/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
