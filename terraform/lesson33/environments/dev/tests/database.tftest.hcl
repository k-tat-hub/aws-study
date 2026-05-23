mock_provider "aws" {
  override_during = plan
}

variables {
  vpc_id               = "vpc-12345678"
  subnet_private_a_id  = "subnet-12345678"
  subnet_private_c_id  = "subnet-87654321"
  ec2_sg_id            = "sg-ec2"
  db_password          = "test-password"
  db_engine_version    = "8.0"
  db_instance_class    = "db.t3.micro"
  db_multi_az          = false
  db_availability_zone = "ap-northeast-1a"
}

run "rds_security_group_test" {
  command = plan

  module {
    source = "../../modules/database"
  }

  # 3306がEC2のセキュリティグループからのみ許可されている
  assert {
    condition = anytrue([
      for rule in output.rds_sg_ingress_rules :
      rule.protocol == "tcp" &&
      rule.from_port == 3306 &&
      rule.to_port == 3306 &&
      contains(coalesce(rule.security_groups, []), "sg-ec2")
    ])

    error_message = "RDS must allow MySQL access only from EC2 security group"
  }

  # 全開放禁止
  assert {
    condition = alltrue([
      for rule in output.rds_sg_ingress_rules :
      !contains(coalesce(rule.cidr_blocks, []), "0.0.0.0/0")
      if rule.from_port == 3306
    ])

    error_message = "RDS must not be publicly accessible"
  }

  # アウトバウンド
  assert {
    condition = anytrue([
      for rule in output.rds_sg_egress_rules :
      rule.protocol == "-1" &&
      contains(coalesce(rule.cidr_blocks, []), "0.0.0.0/0")
    ])

    error_message = "RDS must allow outbound traffic"
  }
}

run "rds_instance_configuration_test" {
  command = plan

  module {
    source = "../../modules/database"
  }

  assert {
    condition     = output.db_engine == "mysql"
    error_message = "DB engine must be mysql"
  }

  assert {
    condition     = output.db_engine_version == "8.0"
    error_message = "DB engine version must be 8.0"
  }

  assert {
    condition     = output.db_instance_class == "db.t3.micro"
    error_message = "DB instance class must be db.t3.micro"
  }

  assert {
    condition     = output.db_publicly_accessible == false
    error_message = "RDS must not be publicly accessible"
  }

  assert {
    condition     = output.db_multi_az == false
    error_message = "Multi-AZ setting mismatch"
  }

  assert {
    condition     = output.db_storage_encrypted == true
    error_message = "Storage must be encrypted"
  }
}