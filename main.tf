provider "aws" {
  region = var.aws_region
}

# VPC MODULE
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr         = var.vpc_cidr
  public_subnet_1  = var.public_subnet_1
  public_subnet_2  = var.public_subnet_2
  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2
}

# PUBLIC EC2
module "public_ec2" {
  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet1_id
  key_name      = var.key_name
  instance_name = "public-server"
  public_ip     = true
  vpc_id        = module.vpc.vpc_id
}

# PRIVATE EC2 - 1
module "private_ec2_1" {
  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.private_subnet1_id
  key_name      = var.key_name
  instance_name = "private-server-1"
  public_ip     = false
  vpc_id        = module.vpc.vpc_id
}

# RDS MODULE
module "rds" {
  source = "./modules/rds"

  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  private_subnet_1  = module.vpc.private_subnet1_id
  private_subnet_2  = module.vpc.private_subnet2_id
  vpc_id            = module.vpc.vpc_id
}