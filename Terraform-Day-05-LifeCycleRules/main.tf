resource "aws_instance" "dynamodb" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  tags = {
    Name="Dynamo DB Server Test"
  }

#   lifecycle {
#     prevent_destroy = true
#   }

#   lifecycle {
#     ignore_changes = [ tags ]
#   }

lifecycle {
  create_before_destroy = true
}
}
