resource "aws_instance" "dev" {
  ami = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  tags = {
    Name: "Cust VPC 2"
  }

}

resource "aws_vpc" "name" {
  cidr_block = "10.1.0.0/16"
  depends_on = [ aws_instance.dev ]
}

# In Terraform, depends_on is used to explicitly define resource dependencies — ensuring that one resource is created only after another has been successfully created.

