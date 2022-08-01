output "vpc_id_iat" {
  value = aws_vpc.main_vpc.id
}

output "cidr_block_iat" {
  value = aws_vpc.main_vpc.cidr_block
}

output "public_subnet_iat" {
  value = aws_subnet.public_subnet.id
}
