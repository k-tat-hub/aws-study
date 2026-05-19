module "network" {
  source = "../../modules/network"
}

module "compute" {
  source = "../../modules/compute"

  vpc_id             = module.network.vpc_id
  public_subnet_a_id = module.network.public_subnet_a_id
  ec2_ami            = var.ec2_ami
  ec2_keypair        = var.ec2_keypair
  MyIP               = var.MyIP
}