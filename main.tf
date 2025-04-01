
resource "aws_elasticache_subnet_group" "elasticache" {
  name       = "elasticache-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.elasticache_cluster_id
  engine               = "redis"
  node_type            = var.cache_node_type
  num_cache_nodes      = var.num_cache_nodes
  engine_version       = var.engine_version
  parameter_group_name = "default.redis7"
  subnet_group_name    = aws_elasticache_subnet_group.elasticache.name
  security_group_ids   = [aws_security_group.elasticache_sg.id]
}