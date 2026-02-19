locals {
  name = "${var.project}-postgres"
}

resource "aws_db_subnet_group" "this" {
  name       = "${local.name}-subnets"
  subnet_ids = var.private_subnet_ids

  tags = merge(var.tags, {
    Name = "${local.name}-subnet-group"
  })
}

resource "aws_security_group" "db" {
  name        = "${local.name}-sg"
  description = "PostgreSQL access only from within VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "PostgreSQL from VPC CIDR only"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${local.name}-sg"
  })
}

resource "aws_db_instance" "this" {
  identifier = "${var.project}-postgres"

  engine         = "postgres"
  engine_version = "16"
  instance_class = var.db_instance_class

  allocated_storage = 20
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 5432

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]

  publicly_accessible = false
  multi_az            = false

  backup_retention_period = 1
  deletion_protection     = true
  skip_final_snapshot     = false
  final_snapshot_identifier = "${var.project}-postgres-final"

  auto_minor_version_upgrade = true

  apply_immediately = true

  tags = merge(var.tags, {
    Name = "${local.name}"
  })
}
