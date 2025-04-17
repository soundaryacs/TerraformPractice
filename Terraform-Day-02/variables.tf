variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
  
}
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}
variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-00a929b66ed6e0de6" # Example AMI ID for Amazon Linux 2 in us-east-1
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
  default     = "state2"
  
}