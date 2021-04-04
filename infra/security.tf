# Create a securtiy group
resource "aws_security_group" "sg_default" {
  for_each = { for index, ec2 in var.ec2_security_group : index => ec2 }

  name        = each.value.server_name
  vpc_id      = module.vpc_main.main_vpc_id
  
  dynamic "ingress" {
    for_each = [for i in each.value.ingress_list : 
      {
        from_port   = i.from_port
        to_port     = i.to_port
        protocol    = i.protocol
        cidr_blocks = i.cidr_blocks
      }]

      content {
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = ingress.value.cidr_blocks
      }
  }

  dynamic "egress" {
    for_each = [for i in var.egress_list : 
      {
        from_port   = i.from_port
        to_port     = i.to_port
        protocol    = i.protocol
        cidr_blocks = i.cidr_blocks
      }]

      content {
        from_port   = egress.value.from_port
        to_port     = egress.value.to_port
        protocol    = egress.value.protocol
        cidr_blocks = egress.value.cidr_blocks
      }      
  }
  
  tags = merge(var.tags, {
    Name        = "sg-${each.value.server_name}"
  },)
}

# Create the key pair for the instances
resource "aws_key_pair" "key_pair" {
    key_name   = var.project_name
    public_key = file(var.public_key)
}