output "instance_public_ip" {
  value = aws_instance.front-end.public_ip
}

output "instance_private_ip" {
  value = aws_instance.front-end.private_ip
  sensitive = false
}

output "instance_subnet_id" {
  value = aws_instance.front-end.subnet_id
  sensitive = false
}