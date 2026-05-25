module "network" {
  source = "../../modules/network"

  vpc_cidr              = var.vpc_cidr
  subnet_public_a_cidr  = var.subnet_public_a_cidr
  subnet_public_c_cidr  = var.subnet_public_c_cidr
  subnet_private_a_cidr = var.subnet_private_a_cidr
  subnet_private_c_cidr = var.subnet_private_c_cidr
  ec2_id                = module.compute.ec2_id
}

module "compute" {
  source = "../../modules/compute"

  vpc_id             = module.network.vpc_id
  subnet_public_a_id = module.network.subnet_public_a_id
  ec2_keypair        = var.ec2_keypair
  ec2_ami            = var.ec2_ami
  ec2_instance_type  = var.ec2_instance_type
  my_ip              = var.my_ip
  alb_sg_id          = module.network.alb_sg_id
}

module "compute_2" {
  source = "../../modules/compute"

  vpc_id             = module.network.vpc_id
  subnet_public_a_id = module.network.subnet_public_a_id
  ec2_keypair        = var.ec2_keypair
  ec2_ami            = var.ec2_ami
  ec2_instance_type  = var.ec2_instance_type
  my_ip              = var.my_ip
  alb_sg_id          = module.network.alb_sg_id
}

module "database" {
  source = "../../modules/database"

  vpc_id               = module.network.vpc_id
  subnet_private_a_id  = module.network.subnet_private_a_id
  subnet_private_c_id  = module.network.subnet_private_c_id
  ec2_sg_id            = module.compute.ec2_sg_id
  db_password          = var.db_password
  db_engine_version    = var.db_engine_version
  db_instance_class    = var.db_instance_class
  db_multi_az          = var.db_multi_az
  db_availability_zone = var.db_availability_zone
}

module "security" {
  source = "../../modules/security"

  alb_arn = module.network.alb_arn
}

module "operation" {
  source = "../../modules/operation"

  alarm_email    = var.alarm_email
  ec2_id         = module.compute.ec2_id
  alb_arn_suffix = module.network.alb_arn_suffix
  web_acl_name   = module.security.web_acl_name
}