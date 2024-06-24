variable "vpc_name" {
  type    = string
  default = "escogram-vpc"
}

variable "vpc_cidr" {
  description = "The network addressing for the escogram VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "The password of the database"
  type        = string
  default     = "RkM$VbG,2%<=pWZHmjfhcT"
  sensitive   = true
}
