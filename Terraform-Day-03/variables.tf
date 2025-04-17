variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = ""
  
}
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "" 
  
}
variable "aws_instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
  default     = ""
  
}
variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
  default     = ""
  
}

variable "s3_bucket" {
  description = "S3 Bucket Creation"
  type = string
  default = ""
}
