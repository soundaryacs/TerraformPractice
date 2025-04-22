# Creation of VPC
resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name: "Custom VPC"
  }
}
# Internet Gateway (IG) to attached to VPC
resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name = "Test-IG"
  }
}
# Creating Subnets
# Public subnet
resource "aws_subnet" "public" {
  cidr_block = "10.0.0.0/24"
  vpc_id = aws_vpc.test.id
#   map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name= "Public Subnet"
  }
}

#Private Subnet
resource "aws_subnet" "private" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.test.id
  availability_zone = "us-east-1a"
  tags = {
    Name: "Private Subnet"
  }
}

# Route d Table (RT) & Edit Routes
resource "aws_route_table" "test" {
  vpc_id = aws_vpc.test.id
  tags = {
    Name: "Test Route"
  }
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id
  }
}

# Subnet Associations

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.test.id
}

# Create Security Group(SG)

resource "aws_security_group" "test" {
  name   = "test"
  vpc_id = aws_vpc.test.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Custom Test SG"
  }
}



# Launch Server (EC2 Instance)

resource "aws_instance" "test" {
  ami                         = "ami-0e449927258d45bc4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.test.id]
  key_name                    = "us-region-cust-key" 
#   associate_public_ip_address = true

  tags = {
    Name = "Test Server"
  }
}

# Task Create NAT Gateway and connected to private subnet
resource "aws_eip" "nat_eip" {
  vpc = true
}


# NAT gate way 
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT Gateway"
  }

  depends_on = [aws_internet_gateway.test]
}

# Private route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

# Associate Route Table for private subnet

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}





