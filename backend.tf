terraform {
  backend "s3" {
    bucket = "terraform-ss-bucket2"
    key = "terrform.tfstate"
    region = "ap-south-1"
    
  }
}