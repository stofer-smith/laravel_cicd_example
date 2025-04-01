# This script creates an ElastiCache Redis cluster in AWS.
# Make sure to replace the placeholders with your actual values.
aws elasticache create-cache-cluster \
  --cache-cluster-id laravel-redis \
  --engine redis \
  --cache-node-type cache.t3.micro \
  --num-cache-nodes 1 \
  --security-group-ids sg-02ae692d4efb7242b