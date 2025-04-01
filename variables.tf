variable "vpc_id" { default = "vpc-0f0eee1c6b46eda32" }
variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0a7081030b5d3869d",
    "subnet-0ffeea9e130022952",
    "subnet-01cec3ed0b7b9d37b",
    "subnet-0b11ddac4679b1540",
    "subnet-0a1a025f8a58aa9ab",
    "subnet-09d4812bb0ea56ca9"
  ]
}
variable "security_group_id" { default = "sg-02ae692d4efb7242b" }
variable "cache_node_type" { default = "cache.t3.micro" }
variable "engine_version" { default = "7.0" }  # Adjust for your Redis version
variable "elasticache_cluster_id" { default = "laravel-cache" }
variable "num_cache_nodes" { default = 1 }

locals {
  envs = { for tuple in regexall("(.*)=(.*)", file("tf.env")) : tuple[0] => sensitive(tuple[1]) }
}

# locals {
#   envs = { for tuple in regexall("(.*)=(.*)", file("tf.env")) : tuple[0] => tuple[1] }
# }