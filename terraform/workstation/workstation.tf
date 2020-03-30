# AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
# cloud init template
data "template_file" "onboard" {
  template = "${file("${path.module}/templates/onboard.yaml")}"

  vars = {
    terraformVersion = "${var.terraformVersion}"
    awscliVersion = "${var.awscliVersion}"
  }

}
# cloud init template
data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = "${data.template_file.onboard.rendered}"
  }
}
# interface external
resource "aws_network_interface" "mgmt" {
  subnet_id       = "${var.mgmt_subnet.id}"
  security_groups = ["${var.securityGroup.id}"]
}
# public address
resource "aws_eip" "mgmt" {
  vpc                       = true
  network_interface         = "${aws_network_interface.mgmt.id}"
}

# instance
resource "aws_instance" "workstation" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instanceType}"
  key_name = "${var.key_name}"
  user_data_base64 = "${data.template_cloudinit_config.config.rendered}"
  public_ip = "${aws_eip.mgmt}"
  #associate_public_ip_address = true

  network_interface {
    network_interface_id = "${aws_network_interface.mgmt.id}"
    device_index         = 0
  }
   root_block_device { delete_on_termination = true }
  

}