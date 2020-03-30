# provider
provider "aws" {
  
}

# vpc
resource "aws_vpc" "mgmt" {
  cidr_block = "10.0.0.0/16"
}
# subnet
resource "aws_subnet" "mgmt" {
  vpc_id     = "${aws_vpc.mgmt.id}"
  cidr_block = "10.0.1.0/24"
}
resource "aws_security_group" "allow_ssh" {
  name        = "${var.projectPrefix}allow_ssh-${random_pet.buildSuffix.id}"
  description = "Allow ssh inbound traffic"
  vpc_id      = "${aws_vpc.mgmt.id}"

  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.adminSrcAddr}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
# internet gateway
resource "aws_internet_gateway" "mgmt" {
  vpc_id = "${aws_vpc.mgmt.id}"
}
# route internet gatway
resource "aws_route_table" "mgmt" {
  vpc_id = "${aws_vpc.mgmt.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mgmt.id}"
    
  }
}
# route table association
resource "aws_route_table_association" "mgmt" {
  gateway_id     = aws_internet_gateway.mgmt.id
  route_table_id = aws_route_table.mgmt.id
}

# workspace machine
module "workstation" {
  source   = "./workstation"
  # vars:
  mgmt_vpc = "${aws_vpc.mgmt}"
  mgmt_subnet = "${aws_subnet.mgmt}"
  securityGroup = "${aws_security_group.allow_ssh}"
  key_name = "${var.awsKeyName}"
  projectPrefix = "${var.projectPrefix}"
  buildSuffix = "-${random_pet.buildSuffix.id}"
  awscliVersion ="${var.awscliVersion}"
  instanceType = "${var.instanceType}"
  terraformVersion = "${var.terraformVersion}"

}
resource "random_pet" "buildSuffix" {
  keepers = {
    # Generate a new pet name each time we switch to a new AMI id
    #ami_id = "${var.ami_id}"
    prefix = "${var.projectPrefix}"
  }
  #length = ""
  #prefix = "${var.projectPrefix}"
  separator = "-"
}