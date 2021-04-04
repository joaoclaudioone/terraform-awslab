# Create EC2 instances
resource "aws_instance" "ec2_instance" {
  count = var.instance_count

  ami                     = data.aws_ami.latest_ami.id
  instance_type           = var.instance_type
  subnet_id               = element(var.subnet_ids, count.index)
  vpc_security_group_ids  = var.security_group
  key_name                = var.public_key
  disable_api_termination = var.api_termination

  credit_specification {
    cpu_credits = var.credit_specification
  }

  root_block_device  {
    delete_on_termination = var.ebs_delete_on_termination
    volume_size           = var.volume_size
    tags                  = var.tags
  }

  tags = var.tags
}

output "public_dns" {
  value = aws_instance.ec2_instance.*.public_dns
}

output "private_dns" {
  value = aws_instance.ec2_instance.*.private_dns
}