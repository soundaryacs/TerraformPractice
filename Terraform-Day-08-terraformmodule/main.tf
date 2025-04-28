# Terraform module to create an EC2 instance in local directory
module "test" {
  source              = "../Terraform-Day-08-terraformmodule-resource"
  aws_region          = "us-east-1"
  ami_id              = "ami-00a929b66ed6e0de6"
  aws_instance_type   = "t2.micro"
  instance_name       = "test"
}
# GitHub URL: as a source
# module "test" {
#   source              = "git::https://github.com/soundaryacs/TerraformPractice.git//Terraform-Day-08-terraformmodule-resource"
#   aws_region          = "us-east-1"
#   ami_id              = "ami-00a929b66ed6e0de6"
#   aws_instance_type   = "t2.micro"
#   instance_name       = "test"
# }

# module "s3_bucket" {
#   source = "terraform-aws-modules/s3-bucket/aws"

#   bucket = "my-bucket-1234567890"
#   #acl    = "private"

# #   control_object_ownership = true
# #   object_ownership         = "ObjectWriter"

#   versioning = {
#     enabled = true
#   }
# }
