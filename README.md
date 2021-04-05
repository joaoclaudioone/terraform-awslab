# terraform-awsvpclab
This repository has two modules that create VPC and EC2 instances. 

## Requirements
| Requirements   |
|----------------|
| AWS Credentials to create the resources |
| Terraform 0.14.x |
| SSH keys |
 
## Example
inside the infra directory you could check for a basic usage. That will create the vpc and two EC2 , one in the public subnet and other in a private subnet
 
## Inputs
 
### VPC
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| project_name | Prefix of the resources, whitespaces are not allowed | `string` | n/a | yes |
| tags | Common tags | `map(string)` | n/a | yes |
| vpc_cidr_block | The CIDR block for the VPC | `string` | n/a | no |
| dns_support | Boolean flag to enable/disable DNS support in the VPC | `bool` | `true` | no |
| dns_hostnames | Boolean flag to enable/disable DNS hostnames in the VPC | `bool` | `true` | no |
| dns_servers | List of name servers to configure in /etc/resolv.conf | `list` | `"AmazonProvidedDNS"` | no |
| subnets_info | Subnets information | `map` | n/a | yes |
 
### EC2
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| tags | Common tags | `map(string)` | n/a | yes |
| query_ami | Values for query ami | `map` | n/a | yes |
| instance_type | Instance type | `string` | `"t2.micro"` | no |
| public_key | File with the public ssh key | `string` | n/a | yes |
| security_group | Security Group id for instances | `list` | n/a | yes |
| subnet_ids | List with the id of subnets | `list` | n/a | yes |
| instance_count | Quantity of instances that will be created | `number` | 1 | no |
| credit_specification | Customize the credit specification of the instance | `string` | `"standard"` | no |
| ebs_delete_on_termination | If true will delete the block EBS on termination | `bool` | `true` | no |
| volume_size | Size of the volume in gibibytes | `number` | `8` | no |
| api_termination | If true, enables EC2 Instance Termination Protection | `bool` | `false` | no |
 
## Outputs
### VPC 
| Name | Description |
|------|-------------|
| vpc_id | AWS VPC id |
| private_subnet_a | Private subnets IDs |
| public_subnet_a | Public subnets IDs |

### EC2
| Name | Description |
|------|-------------|
| ec2_webserver | Webserver EC2 address |
| ec2_database | Database EC2 address |