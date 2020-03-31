# aws-tf-workspace
Terraform workspace deployed in AWS with Terraform and awscli

# deploy the workstation with your tool of choice:

# Prerequisites
 - aws credentials
 - aws EC2 SSH keyPair

## Options:
- [CFT](https://console.aws.amazon.com/cloudformation/home)

- [Terraform](https://terraform.io)

- [Terraform Cloud](https://app.terraform.io/)

## Variables
- projectPrefix
    - project prefix/tag for all object names
      
      eg: "user-build-sca-"
- awsRegion
    - aws region where build and resources are created
    
        eg: "us-east-1"
- instanceType
    - instance typesize default is 4x16.
    
        eg: "m4.xlarge"
- awsKeyName
    - Existing aws keypair name
    
        eg: "myAws-keyPair"
- adminSrcAddr
    - admin source address https://www.ipchicken.com/ with cidr mask ip/32
    
        eg: "1.1.1.1/32"
- terraformVersion
    - installed terraform version
    
        eg: "0.12.23"
- awscliVersion
    - version of awscli installed
    
        eg: "2"
- terragruntVersion
    - version of terragrunt installed
    
        eg: "0.23.4"

## env variables
- AWS_ACCESS_KEY_ID 
- AWS_SECRET_ACCESS_KEY
- AWS_DEFAULT_REGION

## Connect with VS Code Remote Development
- https://code.visualstudio.com/docs/remote/remote-overview

    Open Extensions menu: 

    ![alt text][vscodeExtensions]

    [vscodeExtensions]: images/vscodeExtensions.PNG "vscode extensions"

    Add Remote Devpack Extensions: 

    ![alt text][devPack]

    [devPack]: images/remoteDevPack.PNG "Remote Dev Pack"

    Configure Remote SSH extension: 

    ![alt text][remoteExt] ![alt text][remoteConfig]

    ![alt text][sshConfig]

    [remoteExt]: images/remoteIcon.PNG "Remote SSH icon"

    [remoteConfig]: images/remoteConfig.PNG "Remote SSH config"

    [sshConfig]: images/sshConfig.PNG "SSH config"

## Optional Extensions
- https://marketplace.visualstudio.com/items?itemName=mauve.terraform

