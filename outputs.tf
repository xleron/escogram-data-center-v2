output "default_rds_hostname" {
  description = "The hostname of the default DB"
  value       = aws_db_instance.main_db.address
}

output "alb_dns" {
  description = "The dns name of the ALB"
  value = aws_lb.main_lb.dns_name
}
