variable "db_name" {
    description = "Name of the database to create"
    type        = string
    default     = ""
}
variable "username" {
    description = "Username for the database"
    type        = string
    default     = ""
}
variable "password" {
    description = "Password for the database"
    type        = string
    default     = ""
}
variable "instance_class" {
    description = "Instance class for the RDS instance"
    type        = string
    default = "db.t3.micro"
}
variable "allocated_storage" {
    description = "Allocated storage for the RDS instance in GB"
    type        = number
    default = 20
}
