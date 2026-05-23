mock_provider "aws" {
  override_during = plan

  mock_data "aws_region" {
    defaults = {
      region = "ap-northeast-1"
    }
  }
}

variables {
  vpc_cidr              = "10.0.0.0/16"
  subnet_public_a_cidr  = "10.0.1.0/24"
  subnet_public_c_cidr  = "10.0.2.0/24"
  subnet_private_a_cidr = "10.0.3.0/24"
  subnet_private_c_cidr = "10.0.4.0/24"
  ec2_id                = "i-1234567890abcdef0"
}

run "vpc_cidr_test" {
  command = plan

  module {
    source = "../../modules/network"
  }

  assert {
    condition     = output.vpc_cidr == "10.0.0.0/16"
    error_message = "VPC CIDR block must be 10.0.0.0/16"
  }
}

run "subnet_cidr_test" {
  command = plan

  module {
    source = "../../modules/network"
  }

  assert {
    condition     = output.subnet_public_a_cidr == "10.0.1.0/24"
    error_message = "Public subnet a CIDR must be 10.0.1.0/24"
  }

  assert {
    condition     = output.subnet_public_c_cidr == "10.0.2.0/24"
    error_message = "Public subnet c CIDR must be 10.0.2.0/24"
  }

  assert {
    condition     = output.subnet_private_a_cidr == "10.0.3.0/24"
    error_message = "Private subnet a CIDR must be 10.0.3.0/24"
  }

  assert {
    condition     = output.subnet_private_c_cidr == "10.0.4.0/24"
    error_message = "Private subnet c CIDR must be 10.0.4.0/24"
  }
}

run "alb_security_group_test" {
  command = plan

  module {
    source = "../../modules/network"
  }

  assert {
    condition = anytrue([
      for rule in output.alb_sg_ingress_rules :
      rule.protocol == "tcp" &&
      rule.from_port == 80 &&
      rule.to_port == 80 &&
      contains(coalesce(rule.cidr_blocks, []), "0.0.0.0/0")
    ])

    error_message = "ALB security group must allow HTTP (TCP/80) from 0.0.0.0/0"
  }

  assert {
    condition = anytrue([
      for rule in output.alb_sg_egress_rules :
      rule.protocol == "-1" &&
      rule.from_port == 0 &&
      rule.to_port == 0 &&
      contains(coalesce(rule.cidr_blocks, []), "0.0.0.0/0")
    ])

    error_message = "ALB security group must allow all outbound traffic"
  }
}