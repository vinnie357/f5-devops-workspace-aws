variable adminSrcAddr {
    description = "admin source in cidr 192.168.100.100/32"
}

variable awsRegion {
    default = "us-east-1"
}

variable instanceType {
    description = "machine size"
}

variable awsKeyName {
    description = "your existing aws key pair"
}

variable projectPrefix {
   description = "prefix for created items"
}
variable onboardScript { 
    description = "URL to userdata onboard script"
}
variable repositories { 
    description = "comma seperated list of git repositories to clone"
}
