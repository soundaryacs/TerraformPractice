
module "compute" {
  source = "./modules/compute"
  instance_name = "my-instance"
  instance_type = "t2.micro"
  ami           = "ami-0e449927258d45bc4" 
  
}

module "storage" {
  source      = "./modules/storage"
  bucket_name = "buyoobuy.com"
}


module "rds" {
  source          = "./modules/rds"
  db_name         = "testdb"
  username        = "admin"
  password        = "Test1234Pass!"
  instance_class  = "db.t3.micro"
  allocated_storage = 20
}


