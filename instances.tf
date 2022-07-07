resource "aws_key_pair" "flask-api-key" {
  key_name   = "flask-api-key"
  public_key = file(var.public_key)
}

resource "aws_instance" "flask-api" {
  count                  = var.replicas
  ami                    = var.image_id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.flask-api-key.key_name
  subnet_id              = aws_subnet.flask-api-public1.id
  vpc_security_group_ids = [aws_security_group.flask-api-web.id]

  tags = {
    Name = "flask-api-${count.index + 1}"
    Ansible = "true"
    Task = "web_server"
  }
}

output "instance_ip_addr" {
  value = aws_instance.flask-api.*.public_ip
}

output "instance_dns_addr" {
  value = aws_instance.flask-api.*.public_dns
}
