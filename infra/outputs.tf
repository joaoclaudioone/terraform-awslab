output "vpc_id" {
  value = module.vpc_main.main_vpc_id
}

output "private_subnet_a" {
    value = module.vpc_main.vpc_subnets.private_subnet_a.id
}

output "public_subnet_a" {
    value = module.vpc_main.vpc_subnets.public_subnet_a.id
}

output "ec2_webserver" {
  value = module.ec2_webserver
}

output "ec2_database" {
  value = module.ec2_database
}