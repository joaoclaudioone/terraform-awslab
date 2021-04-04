# Create VPC and define the outputs
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.dns_hostnames

  tags = merge(var.tags, {
    Name        = "${var.project_name}-vpc"
  })
}

output "main_vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "main_vpc_cidr" {
  value = aws_vpc.main_vpc.cidr_block
}

# DHCP options
resource "aws_vpc_dhcp_options" "main_vpc_dhcp_options" {
  domain_name         = var.project_name
  domain_name_servers = var.dns_servers
}

resource "aws_vpc_dhcp_options_association" "main_vpc_dhcp_opts_assoc" {
  vpc_id          = aws_vpc.main_vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.main_vpc_dhcp_options.id
}

# Internet Gateway
resource "aws_internet_gateway" "main_vpc_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(var.tags, { 
    Name = "${var.project_name}-igw"
  },)
}

output "main_vpc_igw_id" { 
  value = aws_internet_gateway.main_vpc_igw.id 
}

# Public Route Table
resource "aws_route_table" "main_vpc_rt_igw" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_vpc_igw.id
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-rt-internet"
  },)
}

# VPC endpoint that allow update the OS
resource "aws_vpc_endpoint" "amz_linux_updates" {
  vpc_id          = aws_vpc.main_vpc.id
  service_name    = "com.amazonaws.${data.aws_region.current.id}.s3"
  route_table_ids = [aws_vpc.main_vpc.default_route_table_id]

  tags = merge(var.tags, {
    Name = "${var.project_name}-s3-endpoint"
  },)
}