resource "aws_instance" "dynamodb" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  tags = {
    Name="Dynamo DB Server Test"
  }
}