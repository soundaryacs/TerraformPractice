module "test" {
  source              = "git::https://github.com/soundaryacs/TerraformPractice.git//Terraform-Day-08-terraformmodule-resource"
  aws_region          = "us-east-1"
  ami_id              = "ami-00a929b66ed6e0de6"
  aws_instance_type   = "t2.micro"
  instance_name       = "test"
}
