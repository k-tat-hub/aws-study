mock_provider "aws" {
  override_during = plan
}

variables {
  vpc_id             = "vpc-12345678"
  subnet_public_a_id = "subnet-12345678"
  ec2_keypair        = "test-keypair"
  ec2_ami            = "ami-12345678"
  ec2_instance_type  = "t3.small"
  my_ip              = "1.2.3.4"
  alb_sg_id          = "sg-12345678"
}

run "ec2_instance_configuration_test" {
  command = plan

  module {
    source = "../../modules/compute"
  }

  assert {
    condition     = output.ec2_instance_type == "t3.micro"
    error_message = "EC2 instance type must be t3.micro"
  }

  assert {
    condition     = output.ec2_public_ip_enabled == true
    error_message = "EC2 instance must have a public IP"
  }
}

run "ec2_security_group_test" {
  command = plan

  module {
    source = "../../modules/compute"
  }

  # SSH許可
  assert {
    condition = anytrue([
      for rule in output.ec2_sg_ingress_rules :
      rule.protocol == "tcp" &&
      rule.from_port == 22 &&
      rule.to_port == 22 &&
      length(coalesce(rule.cidr_blocks, [])) > 0 &&
      !contains(coalesce(rule.cidr_blocks, []), "0.0.0.0/0")
    ])

    error_message = "EC2 security group must allow SSH access only from the specified IP"
  }

  # HTTP許可(ALB経由)
  assert {
    condition = anytrue([
      for rule in output.ec2_sg_ingress_rules :
      rule.protocol == "tcp" &&
      rule.from_port == 80 &&
      rule.to_port == 80 &&
      length(coalesce(rule.security_groups, [])) > 0
    ])

    error_message = "EC2 security group must allow HTTP access from the ALB security group"
  }

  # SSH全開放禁止
  assert {
  condition = alltrue([
    for rule in output.ec2_sg_ingress_rules :
    !contains(coalesce(rule.cidr_blocks, []), "0.0.0.0/0")
    if rule.from_port == 22 && rule.to_port == 22
  ])

  error_message = "Security risk: SSH access must not be open to the world"
  }

  # アウトバウンド
  assert {
    condition = anytrue([
      for rule in output.ec2_sg_egress_rules :
      rule.protocol == "-1" &&
      rule.from_port == 0 &&
      rule.to_port == 0 &&
      contains(rule.cidr_blocks, "0.0.0.0/0")
    ])

    error_message = "EC2 security group must allow all outbound traffic"
  }
}