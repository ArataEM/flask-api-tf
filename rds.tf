resource "aws_db_subnet_group" "flask-api-db" {
  name       = "flask-api-db"
  subnet_ids = [aws_subnet.flask-api-private1.id, aws_subnet.flask-api-private2.id]

  tags = {
    Name = "flask-api-db"
  }
}

resource "aws_db_instance" "flask-api-db" {
  identifier             = "flask-api-db"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = aws_db_subnet_group.flask-api-db.name
  vpc_security_group_ids = [aws_security_group.flask-api-db.id]
  #db_name                = "flaskapi"
  username               = "devops"
  password               = "devops123"
  skip_final_snapshot    = true
}

output "rds_endpoint" {
  value = aws_db_instance.flask-api-db.endpoint
}
