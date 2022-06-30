resource "aws_vpc" "flask-api" {
  cidr_block = "10.1.0.0/16"
  enable_dns_hostnames = true
  
  tags = {
    Name = "flask-api"
  }
}

resource "aws_subnet" "flask-api-public1" {
  vpc_id     = aws_vpc.flask-api.id
  cidr_block = "10.1.1.0/24"
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "flask-api-public1"
  }
}

resource "aws_subnet" "flask-api-public2" {
  vpc_id     = aws_vpc.flask-api.id
  cidr_block = "10.1.2.0/24"
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "flask-api-public2"
  }
}

resource "aws_subnet" "flask-api-private1" {
  vpc_id     = aws_vpc.flask-api.id
  cidr_block = "10.1.3.0/24"
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "flask-api-private1"
  }
}

resource "aws_subnet" "flask-api-private2" {
  vpc_id     = aws_vpc.flask-api.id
  cidr_block = "10.1.4.0/24"
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "flask-api-private2"
  }
}

resource "aws_internet_gateway" "flask-api-igw" {
  vpc_id = aws_vpc.flask-api.id

  tags = {
    Name = "flask-api-igw"
  }
}

resource "aws_route_table" "flask-api-public-rt" {
  vpc_id = aws_vpc.flask-api.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.flask-api-igw.id
  }

  tags = {
    Name = "flask-api-public-rt"
  }
}

resource "aws_route_table" "flask-api-private-rt" {
  vpc_id = aws_vpc.flask-api.id

  route = []

  tags = {
    Name = "flask-api-private-rt"
  }
}

resource "aws_route_table_association" "flask-api-public1" {
  subnet_id      = aws_subnet.flask-api-public1.id
  route_table_id = aws_route_table.flask-api-public-rt.id
}

resource "aws_route_table_association" "flask-api-public2" {
  subnet_id      = aws_subnet.flask-api-public2.id
  route_table_id = aws_route_table.flask-api-public-rt.id
}

resource "aws_route_table_association" "flask-api-private1" {
  subnet_id      = aws_subnet.flask-api-private1.id
  route_table_id = aws_route_table.flask-api-private-rt.id
}

resource "aws_route_table_association" "flask-api-private2" {
  subnet_id      = aws_subnet.flask-api-private2.id
  route_table_id = aws_route_table.flask-api-private-rt.id
}
