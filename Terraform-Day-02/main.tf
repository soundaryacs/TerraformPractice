resource "aws_instance" "name" {
  instance_type = var.instance_type
  ami           = var.ami_id
    tags = {
        Name = var.instance_name
    }
}