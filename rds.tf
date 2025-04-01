provider "aws" {
  region = "us-east-2" # Change to your region
}

# Fetch VPC
data "aws_vpc" "eks_vpc" {
  id = "vpc-0f0eee1c6b46eda32"
}

# Fetch Private Subnets
data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.eks_vpc.id]
  }
}

# Fetch EKS Security Group
data "aws_security_group" "eks_sg" {
  id = "sg-02ae692d4efb7242b"
}

# Create Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-mysql-sg"
  description = "Allow MySQL traffic from EKS"
  vpc_id      = data.aws_vpc.eks_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [data.aws_security_group.eks_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-mysql-subnet-group"
  subnet_ids = data.aws_subnets.private_subnets.ids

  tags = {
    Name = "RDS MySQL Subnet Group"
  }
}

# Create RDS MySQL Instance
resource "aws_db_instance" "rds_mysql" {
  identifier             = "eks-mysql-db"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.medium"
  allocated_storage      = 20
  storage_type           = "gp3"
  db_name                = local.envs["DB_DATABASE"]
  username               = local.envs["DB_USERNAME"]
  password               = local.envs["DB_PASSWORD"] # Use AWS Secrets Manager instead for security
  parameter_group_name   = "default.mysql8.0"
  multi_az               = false
  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  backup_retention_period = 7
  skip_final_snapshot    = true

  tags = {
    Name = "eks-mysql-rds"
  }
}
output "envs" {
  value = local.envs["DB_DATABASE"]
  sensitive = true # this is required if the sensitive function was used when loading .env file (more secure way)
}