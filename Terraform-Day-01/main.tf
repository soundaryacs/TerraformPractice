resource "aws_instance" "name" {
  ami = var.ami_id
  instance_type = var.aws_instance_type
  key_name = var.key_pair

  tags = {
    Name = "Frontend"
  }
}