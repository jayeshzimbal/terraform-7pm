resource "aws_db_instance" "default" {
  allocated_storage    = 10

  identifier           = "test-rds"   
  db_name              = "test"     
  engine               = "mysql"
  engine_version       = "8.0"

  instance_class       = "db.t3.micro"

  username             = "jayesh"
  password             = "foobarbaz"

  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true

  publicly_accessible  = true          # (optional, for testing)
}
