vpc_cidr              = "10.0.0.0/16"
subnet_public_a_cidr  = "10.0.1.0/24"
subnet_public_c_cidr  = "10.0.2.0/24"
subnet_private_a_cidr = "10.0.3.0/24"
subnet_private_c_cidr = "10.0.4.0/24"

ec2_ami           = "ami-0e668174d57c64015"
ec2_instance_type = "t3.micro"

db_engine_version    = "8.0.46"
db_instance_class    = "db.t3.micro"
db_multi_az          = false
db_availability_zone = "ap-northeast-1a" # db_multi_azがtrueの場合、db_availability_zoneはnullになりaws側で自動選択される