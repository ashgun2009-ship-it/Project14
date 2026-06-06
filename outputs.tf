output "alb_dns_name" {
  value       = module.application.alb_dns_name
  description = "The DNS name of the application load balancer"
}