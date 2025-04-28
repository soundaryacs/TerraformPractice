resource "aws_db_instance" "default" {
  allocated_storage       = 10
   identifier =             "book-rds"
  db_name                 = "mydb"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "Cloud123"
  db_subnet_group_name    = aws_db_subnet_group.sub-grp.id
  parameter_group_name    = "default.mysql8.0"
  provider = aws.primary

  # Enable backups and retention
  backup_retention_period  = 1   # Retain backups for 1 days
  backup_window            = "02:00-03:00" # Daily backup window (UTC)

  # Enable monitoring (CloudWatch Enhanced Monitoring)
  monitoring_interval      = 60  # Collect metrics every 60 seconds
  monitoring_role_arn      = aws_iam_role.rds_monitoring.arn

  # Enable performance insights
  # performance_insights_enabled          = true
  # performance_insights_retention_period = 1  # Retain insights for 7 days

  # Maintenance window
  maintenance_window = "sun:04:00-sun:05:00"  # Maintenance every Sunday (UTC)

  # Enable deletion protection (to prevent accidental deletion)
  deletion_protection = true

  # Skip final snapshot
  skip_final_snapshot = true

  depends_on = [aws_db_instance.default]
}

# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "rds_monitoring" {
  name = "rds-monitoring-role"
  provider = aws.primary
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      }
    }]
  })
}

# IAM Policy Attachment for RDS Monitoring
resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
    provider = aws.primary
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}


resource "aws_db_subnet_group" "sub-grp" {
  name       = "mycutsubnet"
  subnet_ids = ["subnet-0d9af198dfd45141c", "subnet-0e87f51ae72f64add"]
  provider = aws.primary

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "read_replica" {
  provider             = aws.secondary
  identifier           = "book-rds-replica"
  replicate_source_db  = aws_db_instance.default.arn
  instance_class       = "db.t3.micro"
  db_subnet_group_name = aws_db_subnet_group.secondary_region_group.name
  publicly_accessible  = true

  depends_on = [aws_db_instance.default]
}

resource "aws_db_subnet_group" "secondary_region_group" {
  name       = "secondary-subnet-group"
  subnet_ids = [aws_subnet.public1.id, aws_subnet.public2.id]
  tags = {
    Name = "Secondary Region Subnet Group"
  }
}


# VPC
resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name= "devvpc"
    }
  
}
# IG and attch to vpc
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.dev.id
  
}
# Subnets 

resource "aws_subnet" "public1" {
  provider          = aws.primary
  vpc_id            = aws_vpc.dev.id   # Correct dependency
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "public2" {
  provider          = aws.primary
  vpc_id            = aws_vpc.dev.id   # Correct dependency
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}

# RT, # edit routes 
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}

# subnet associations
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.public1.id
    route_table_id = aws_route_table.name.id
  
}
resource "aws_route_table_association" "name2" {
    subnet_id = aws_subnet.public2.id
    route_table_id = aws_route_table.name.id
  
}