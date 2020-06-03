resource random_pet buildSuffix {
  keepers = {
    # Generate a new pet name each time we switch to a new AMI id
    #ami_id = "${var.ami_id}"
    prefix = var.projectPrefix
  }

  #length = ""
  #prefix = "${var.projectPrefix}"
  separator = "-"
}

# workspace machine
module workstation {
  source = "./workstation"
  # vars:
  mgmt_vpc          = aws_vpc.mgmt
  mgmt_subnet       = aws_subnet.mgmt
  securityGroup     = aws_security_group.allow_ssh
  key_name          = var.awsKeyName
  projectPrefix     = var.projectPrefix
  buildSuffix       = "-${random_pet.buildSuffix.id}"
  instanceType      = var.instanceType
  repositories      = var.repositories
}

