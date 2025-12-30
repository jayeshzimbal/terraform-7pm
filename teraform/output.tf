output "jayesh" {
  value = aws_instance.name.public_ip
}

output "jay" {
    value = aws_instance.name.private_ip
  
}