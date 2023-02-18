resource "aws_vpc" "oun-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    instance_tenancy = "default"    

}
resource "aws_subnet" "oun-subnet-public-1" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true" 
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-public-2" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-public-3" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-private-1" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.4.0/24"
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-private-2" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.5.0/24"
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-private-3" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.6.0/24"
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-db-1" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.7.0/24"
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-db-2" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.8.0/24"
    availability_zone = "eu-central-1a"

}
resource "aws_subnet" "oun-subnet-db-3" {
    vpc_id = "${aws_vpc.oun-vpc.id}"
    cidr_block = "10.0.9.0/24"
    availability_zone = "eu-central-1a"

}

resource "aws_security_group" "SC" {
  name        = "SC Terraform"
  description = "Allow http and ssh"
  vpc_id      = aws_vpc.oun-vpc.idingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }tags = {
    Name = "SC_OUN"
  }
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id =  aws_eip.nat.id
  subnet_id     = aws_subnet.private.id
  depends_on = [aws_internet_gateway.gw]
tags = {
    Name = "gw NAT"
  }
}
resource "aws_route_table" "forprivate" {
  vpc_id = aws_vpc.oun-vpc.id
route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
tags = {
    Name = "RT"
  }
}
resource "aws_security_group" "database" {
  name        = "for_sql"
  description = "Allow sql and ssh"
  vpc_id      = aws_vpc.oun-vpc.idingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
    security_groups = [aws_security_group.SC_OUN.id]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }tags = {
    Name = "db_sg"
  }
}
