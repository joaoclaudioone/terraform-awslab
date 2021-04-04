# Creation of subnets
resource "aws_subnet" "vpc_subnet" {
  for_each = { for index, subnet in var.subnets_info : index => subnet }

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  availability_zone       = each.value.availability_zone

  tags = merge(var.tags, {
    Name = "${var.project_name}-subnet-${each.value.type}"
  },)
}

# Associate public subnets to public route table
resource "aws_route_table_association" "main_vpc_public_rt" {
  for_each = { for index, subnet in var.subnets_info : index => subnet if subnet.type == "public"}
  
  subnet_id      = aws_subnet.vpc_subnet[each.key].id
  route_table_id = aws_route_table.main_vpc_rt_igw.id
}

output "vpc_subnets" {
  value = aws_subnet.vpc_subnet
}
