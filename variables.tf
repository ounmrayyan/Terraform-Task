variable "access_key" {
        description = "ASIA5PS6YXASKIBZFEMJ"
}
variable "secret_key" {
        description = "SCpJFSrY2wAITNO3hjeH7yYM7Co4gO3pMED3GKiq"
}


variable "private-1" {
        description = "Private-1
        default = "awsbuilder-demo"
}

variable "instance_type" {
        default = "t2.micro"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-0c70c5c8ca7a7f981" , "subnet-0657d84fe7319beff" , "subnet-0718bd252c9a0001a"
}

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-09d56f8956ab235b3"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 3
}


variable "ami_key_pair_name" {
        default = "tomcat"
}