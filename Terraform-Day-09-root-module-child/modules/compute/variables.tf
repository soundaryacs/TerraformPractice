variable "region" {
  description = "The AWS region to deploy the resources in"
  type        = string
  default = ""
}
variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = "t2.micro"
  
}
variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0e449927258d45bc4" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  
}
variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = ""
  
}