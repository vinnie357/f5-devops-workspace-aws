output "workspaceManagementAddress" {
  # Result is a map from instance id to private IP address, such as:
  #  {"i-1234" = "192.168.1.2", "i-5678" = "192.168.1.5"}
  value = {
    for instance in aws_instance.workstation:
    instance.name => "ssh@${instance.network_interface.0.access_config.0.nat_ip}"
  }
}