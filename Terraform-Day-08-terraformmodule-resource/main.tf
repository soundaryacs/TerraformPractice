resource "aws_instance" "this"{
  ami = var.ami_id
  instance_type = var.aws_instance_type
  tags = {
  Name = var.instance_name
  }
}
resource "aws_s3_bucket" "name" {
  bucket = var.s3_bucket
}