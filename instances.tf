resource "aws_key_pair" "flask-api-key" {
  key_name   = "flask-api-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "flask-api" {
  ami           = "ami-065deacbcaac64cf2"
  instance_type = "t2.micro"
  key_name = aws_key_pair.flask-api-key.key_name
  subnet_id = aws_subnet.flask-api-public1.id
  vpc_security_group_ids = [aws_security_group.flask-api-web.id]

  tags = {
    Name = "flask-api"
  }
}

output "instance_ip_addr" {
  value = aws_instance.flask-api.public_ip
}