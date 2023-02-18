resource "aws_db_instance" "default" {
allocated_storage = 20
identifier = "testinstance"
storage_type = "gp2"
engine = "mysql"
engine_version = "5.7"
instance_class = "db.m4.large"
name = "task"
username = "admin"
password = "Admin"
parameter_group_name = "task-task"
}

resource "aws_vpc" "oun-vpc" {
cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "oun-subnet-private-2" {
vpc_id = "${aws_vpc"oun-vpc"}"
cidr_block = "10.0.5.0/24"
availability_zone = "AZ-a of the Region"
}

resource "aws_subnet" "oun-subnt-db-2" {
vpc_id = "${aws_vpc."oun-vpc"}"
cidr_block = "10.0.7.0/24"
availability_zone = "AZ-b of the region"
}

resource "aws_db_subnet_group" "db-subnet" {
name = "DB subnet group"
subnet_ids = ["${aws_subnet.oun-subnet-private-2}", "${aws_subnet.oun-subnet-db-2}"]}

db_subnet_group_name = "${aws_db_subnet_group.db-subnet.name}"
