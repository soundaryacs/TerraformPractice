variable "aws_region" {
    description = "Ec2 Region"
    type = string
    default = ""
  
}

variable "instance_name" {
    description = "EC2 Instance Name"
    type = string
    default = ""
}

variable "ami_id" {
    description = "Enter AMI ID here"
    type = string
    default = ""
}

variable "aws_instance_type" {
    description = "instance type"
    type = string
    default = ""
}

variable "s3_bucket" {
    description = "s3 bucket creation"
    type = string
    default = ""
}