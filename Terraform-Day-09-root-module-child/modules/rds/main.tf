resource "aws_db_instance" "this" {
  identifier             = "my-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  skip_final_snapshot    = true
  publicly_accessible    = true

  
}
