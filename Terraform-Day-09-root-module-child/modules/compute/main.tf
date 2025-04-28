resource "aws_instance" "this" {
  instance_type = var.instance_type
  ami           = var.ami
    tags = {
        Name = var.instance_name
    }
}