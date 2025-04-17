variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type = string
    default = "ami-002f6e91abff6eb96" 
}
variable "aws_instance_type" {
    description = "Ec2 instance Type"
    type = string
    default = "t2.nano"
  
}

variable "key_pair" {
    description = "Key pairs Name"
    type = string
    default = "cust-kp"
}