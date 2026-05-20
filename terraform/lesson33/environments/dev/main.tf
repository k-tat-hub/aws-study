module "network" {
  source = "../../modules/network"

  vpc_cidr              = "10.0.0.0/16"
  subnet_public_a_cidr  = "10.0.1.0/24"
  subnet_public_c_cidr  = "10.0.2.0/24"
  subnet_private_a_cidr = "10.0.3.0/24"
  subnet_private_c_cidr = "10.0.4.0/24"
  ec2_id                = module.compute.ec2_id
}

module "compute" {
  source = "../../modules/compute"

  vpc_id             = module.network.vpc_id
  subnet_public_a_id = module.network.subnet_public_a_id
  ec2_ami            = var.ec2_ami
  ec2_keypair        = var.ec2_keypair
  MyIP               = var.MyIP
  alb_sg_id          = module.network.alb_sg_id
}

module "database" {
  source = "../../modules/database"

  vpc_id              = module.network.vpc_id
  subnet_private_a_id = module.network.subnet_private_a_id
  subnet_private_c_id = module.network.subnet_private_c_id
  ec2_sg_id           = module.compute.ec2_sg_id
  db_engine_version   = var.db_engine_version
  db_instance_class   = var.db_instance_class
  db_password         = var.db_password
}

module "security" {
  source = "../../modules/security"

  alb_arn = module.network.alb_arn
}

module "operation" {
  source = "../../modules/operation"

  ec2_id         = module.compute.ec2_id
  alb_arn_suffix = module.network.alb_arn_suffix
  web_acl_name   = module.security.web_acl_name
  alarm_email    = var.alarm_email
}