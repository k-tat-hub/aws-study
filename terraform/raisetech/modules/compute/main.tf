# ==========================================
# EC2のセキュリティグループ
# ==========================================
resource "aws_security_group" "ec2" {
  name        = "raisetech-ec2-sg"
  description = "Allow connection for SSH and ALB"
  vpc_id      = var.vpc_id

  # SSH (22) の許可
  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "${var.my_ip}/32"
    ]
  }

  # HTTP (80) の許可
  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80

    security_groups = [
      var.alb_sg_id
    ]
  }

  # アウトバウンド
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "raisetech-ec2-sg"
  }
}

# ==========================================
# EC2インスタンスの作成
# ==========================================
resource "aws_instance" "ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.subnet_public_a_id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]
  key_name = var.ec2_keypair

  tags = {
    Name = "raisetech-ec2"
  }
}