/*
 * Commons
 */
variable "project_name" {
  description = "Preffix of the resources, whitespaces are not allowed"
  type        = string
  default     = "awslab"
}

variable "tags" {
  description  = "Common tags"
  type         = map(string)
  default = {
    terraform  = "true"
    repository = "git@github.com:joaoclaudioone/terraform-awslab.git"
  }
}

variable "aws_region" {
  description = "Region that the resources will be created"
  type        = string
  default     = "us-east-2"
 }
 
/*
 * Module VPC
 */
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "172.16.0.0/16"
}

variable "subnets_info" {
  description = "Subnets information"
  type        = map(object({
    cidr_block              = string
    map_public_ip_on_launch = bool
    type                    = string
    availability_zone       = string
  }))
  default = {
    public_subnet_a = {
      cidr_block              = "172.16.1.0/24"
      map_public_ip_on_launch = true
      type                    = "public"
      availability_zone       = "us-east-2a"
    },
    private_subnet_a = {
      cidr_block              = "172.16.2.0/24"
      map_public_ip_on_launch = false
      type                    = "private"
      availability_zone       = "us-east-2a"
    }
  }
}

/*
 * Module EC2
 */
variable "query_ami" {
    description = "Values for query ami"
    type        = map
    default     = {
        owners  = ["amazon", "137112412989"]
        name    = ["amzn-ami-hvm-2018.03.0.20181116-x86_64-gp2"]
    }
}

variable "egress_list" {
  description = "Egress allowed address"
  type        = list
  default     = [
    {
      from_port = 0
      to_port   = 0
      protocol  = -1
      cidr_blocks = ["0.0.0.0/0"]
    }]
}

variable "ec2_security_group" {
  description = "Rules for inbound connections"
  type        = map(object({
    server_name  = string
    ingress_list = list(object({
      from_port    = number
      to_port      = number
      protocol     = string
      cidr_blocks  = list(string)
    }))
  }))
  default = {
    webserver01 = {
      server_name  = "Webserver"
      ingress_list = [{
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }]
    },
    database01 = {
      server_name  = "Database"
      ingress_list = [{
        from_port   = 3110
        to_port     = 3110
        protocol    = "tcp"
        cidr_blocks = ["172.16.1.0/24"]
      },
      {
        from_port   = -1
        to_port     = -1
        protocol    = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["172.16.1.0/24"]
      }]
    }
  }
}

variable "public_key" {
  description = "Path to ssh public key"
  type        = string
  default     = "./keys/ssh-key.pub"
}