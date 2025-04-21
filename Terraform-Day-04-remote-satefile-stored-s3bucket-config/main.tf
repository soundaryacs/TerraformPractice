resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name= "cust-vpc"
    }
}

resource "aws_subnet" "dev" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.dev.id
  tags = {
    Name ="dev"
  }
}

resource "aws_subnet" "test" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.dev.id
  tags = {
    Name ="test"
  }
}