resource "aws_security_group" "elasticache_sg" {
  name        = "elasticache-security-group"
  description = "Allow access to ElastiCache from EKS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    security_groups = [var.security_group_id] # Allow access from EKS SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}