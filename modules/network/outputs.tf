output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output "subnet_ids" {
  value       = [aws_subnet.subnet1.id, aws_subnet.subnet2.id, aws_subnet.subnet3.id]
  description = "List of public subnet IDs"
}
