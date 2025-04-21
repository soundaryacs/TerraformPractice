terraform {
  backend "s3" {
    bucket = "backendstatefileuploadintos3bucket"
    key = "Terraform-Day-04-create-s3bucket-backend-statefile/terraform.tfvars"
    region = "us-east-1"
  }
}