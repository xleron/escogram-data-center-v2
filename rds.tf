resource "aws_db_subnet_group" "default" {
  name        = "default_subnet_group"
  description = "The default subnet group for all DBs in this architecture"

  subnet_ids = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
  ]

  tags = {
    env = "Dev"
  }
}

resource "aws_db_parameter_group" "log_db_parameter" {
  name   = "logs"
  family = "postgres16"

  parameter {
    value = "1"
    name  = "log_connections"
  }

  tags = {
    env = "Dev"
  }
}


resource "aws_db_instance" "main_db" {
  username                = "kavindusanjula"
  skip_final_snapshot     = true
  publicly_accessible     = false
  password                = var.db_password
  parameter_group_name    = aws_db_parameter_group.log_db_parameter.name
  instance_class          = "db.t3.micro"
  engine_version          = "16.1"
  db_name                 = "ravana_db"
  engine                  = "postgres"
  db_subnet_group_name    = aws_db_subnet_group.default.name
  backup_retention_period = 1
  allocated_storage       = 10
  multi_az                = true
  storage_type            = "gp2"

  tags = {
    env = "Dev"
    Name = "main-db"
  }

  vpc_security_group_ids = [
    aws_security_group.sg.id
  ]
}

resource "aws_security_group" "sg" {
  name        = "db_sg"
  description = "Default sg for the database"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "db_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id            = aws_security_group.sg.id
  referenced_security_group_id = aws_security_group.public_sg.id
  from_port                    = 5432
  ip_protocol                  = "tcp"
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_tls_eg" {
  security_group_id            = aws_security_group.public_sg.id
  referenced_security_group_id = aws_security_group.public_sg.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 65535
}

# resource "aws_db_instance" "db_replica" {
#   skip_final_snapshot     = true
#   replicate_source_db     = aws_db_instance.db1.identifier
#   publicly_accessible     = false
#   parameter_group_name    = aws_db_parameter_group.log_db_parameter.name
#   instance_class          = var.instance_class
#   identifier              = "db-replica"
#   backup_retention_period = 7
#   apply_immediately       = true

#   tags = {
#     replica = "true"
#     env     = "Dev"
#   }

#   vpc_security_group_ids = [
#     aws_security_group.sg.id,
#   ]
# }

