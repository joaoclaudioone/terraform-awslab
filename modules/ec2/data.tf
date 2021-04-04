# Datasouce to query AMI
data "aws_ami" "latest_ami" {
  most_recent = true
  owners = var.query_ami.owners

  filter {
    name   = "name"
    values = var.query_ami.name
  }
}