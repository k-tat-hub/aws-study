resource "aws_security_group" "ec2" {
  name        = "lesson33-ec2-sg"
  description = "Allow SSH and HTTP access"
  vpc_id      = var.vpc_id

  # SSH (22) の許可
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${var.MyIP}/32"]
  }

  # HTTP (80) の許可
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  # アウトバウンド（外への通信）を全解放
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lesson33-ec2-sg"
  }
}

resource "aws_instance" "ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instancetype
  subnet_id     = var.public_subnet_a_id
  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]
  key_name = var.ec2_keypair

  tags = {
    Name = "lesson33-ec2"
  }
}