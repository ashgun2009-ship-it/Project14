output "ssh_sg_id" {
  value       = aws_security_group.ssh.id
  description = "SSH SG ID"
}

output "public_http_sg_id" {
  value       = aws_security_group.public_http.id
  description = "Public HTTP SG ID"
}

output "private_http_sg_id" {
  value       = aws_security_group.private_http.id
  description = "Private HTTP SG ID"
}
