resource "aws_instance" "name" {
  ami = var.ami_id
  instance_type = var.aws_instance_type
  tags = {
    Name = var.instance_name
  }
}

resource "aws_s3_bucket" "name" {
  bucket = var.s3_bucket
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}