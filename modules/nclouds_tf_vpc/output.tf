output "id" {
  value = aws_vpc.main.id
}

output "cidr" {
  value = aws_vpc.main.cidr_block
}

output "default_sg" {
  value = aws_default_security_group.default.id
}

output "default_sg_name" {
  value = aws_default_security_group.default.name
}

output "nat_eips" {
  value = aws_eip.nat.*.public_ip
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}

output "private_subnets" {
  value = aws_subnet.private.*.id
}
