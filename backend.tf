terraform {
  backend "s3" {
    bucket = "terrform-sshiva"
    key = "terrform.tfstate"
    region = "ap-south-1"
    
  }
}