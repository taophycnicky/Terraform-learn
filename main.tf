provider "aws" {}

//referencing a global enviromental variable
variable avail_zone{}

//Declaring a variable for subnet1 cidr block
variable "dev-subnet-1" {
  description = "subnet1 cidr block"
}

//Declaring a variable for vpc cidr block
variable "vpc_cidr_block" {
  description = "vpc cidr block"
}

//Declaring a variable for subnet2 cidr block
variable "dev-subnet-2" {
  description = "subnet2 cidr block"
}

variable "enviroment" {
  description = "deployment enviroment"
}
resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name: var.enviroment
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.dev-subnet-1
  availability_zone = var.avail_zone
  tags = {
    Name: "subnet-1-dev"
  }
}

data "aws_vpc" "existing_vpc" {
  cidr_block = "10.0.0.0/16"
  }

  resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
     cidr_block = var.dev-subnet-2
  availability_zone = "eu-north-1b"
  tags = {
    Name: "subnet-2-dev"
  }
  }

  output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
  }

  output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-1.id
  }

  output "dev-subnet2-id" {
    value = aws_subnet.dev-subnet-2.id
  }