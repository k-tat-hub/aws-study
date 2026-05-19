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
    security_groups = [var.alb_sg_id]
  }

  # アウトバウンド（外への通信）を全解放
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "lesson33-ec2-sg" }
}

resource "aws_instance" "ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id     = var.subnet_public_a_id
  vpc_security_group_ids = [
    aws_security_group.ec2.id
  ]
  key_name = var.ec2_keypair

  tags = { Name = "lesson33-ec2" }
}