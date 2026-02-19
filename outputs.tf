output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer (HTTP port 80)"
  value       = module.alb.dns_name
}

output "db_endpoint" {
  description = "RDS PostgreSQL endpoint (private)"
  value       = module.db.db_endpoint
  sensitive   = false
}
