output "default_rds_hostname" {
  description = "The hostname of the default DB"
  sensitive   = true
  value       = aws_db_instance.db1.address
}

output "alb_dns" {
  value = aws_lb.main_lb.dns_name
}
