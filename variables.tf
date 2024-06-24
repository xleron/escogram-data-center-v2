variable "vpc_name" {
  type    = string
  default = "rd-vpc"
}

variable "vpc_cidr" {
  description = "The network addressing for the default VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_password" {
  description = "The password of the database"
  type        = string
  default     = "kavindu2001"
  sensitive   = true
}




