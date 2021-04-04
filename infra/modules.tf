# Module for creation of the VPC infrastructure
module "vpc_main" {
  source = "../modules/vpc"

  project_name   = var.project_name
  tags           = var.tags
  vpc_cidr_block = var.vpc_cidr_block
  subnets_info  = var.subnets_info
}

# Module for creation of the Webserver EC2
module "ec2_webserver" {
  for_each = { for index, ec2 in var.ec2_security_group : index => ec2 if ec2.server_name  == "Webserver" }

  source = "../modules/ec2"
  
  tags            = merge(var.tags, {
    Name = each.value.server_name
  })
  query_ami       = var.query_ami
  security_group  = [aws_security_group.sg_default[each.key].id]
  public_key      = aws_key_pair.key_pair.id
  subnet_ids      = [module.vpc_main.vpc_subnets.public_subnet_a.id]
}

# Module for creation of the Database EC2
module "ec2_database" {
  for_each = { for index, ec2 in var.ec2_security_group : index => ec2 if ec2.server_name  == "Database" }

  source = "../modules/ec2"
  
  tags            = merge(var.tags, {
    Name = each.value.server_name
  })
  query_ami       = var.query_ami
  security_group  = [aws_security_group.sg_default[each.key].id]
  public_key      = aws_key_pair.key_pair.id
  subnet_ids      = [module.vpc_main.vpc_subnets.private_subnet_a.id ]
}