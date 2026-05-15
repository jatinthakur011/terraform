output "public_ec2_ip" {
  value = module.public_ec2.public_ip
}

output "private_ec2_1_id" {
  value = module.private_ec2_1.instance_id
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

# output "vpc"{
#   value = module.vpc.vpc_id
# }