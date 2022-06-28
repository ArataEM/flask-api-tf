resource "aws_security_group" "flask-api-web" {
  name        = "flask-api-web"
  vpc_id      = aws_vpc.flask-api.id

  tags = {
    Name = "flask-api-web"
  }
}

resource "aws_security_group_rule" "allow_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flask-api-web.id
}

resource "aws_security_group_rule" "allow_web" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flask-api-web.id
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flask-api-web.id
}


resource "aws_security_group" "flask-api-db" {
  name        = "flask-api-db"
  vpc_id      = aws_vpc.flask-api.id

  tags = {
    Name = "flask-api-db"
  }
}

resource "aws_security_group_rule" "allow_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.flask-api-web.id
  security_group_id        = aws_security_group.flask-api-db.id
}
