# ==========================================
# 現在のリージョン情報取得
# ==========================================
data "aws_region" "current" {}

# ==========================================
# VPCの作成
# ==========================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = { 
    Name = "lesson33-vpc" 
  }
}

# ==========================================
# サブネットの作成
# ==========================================
# 1a
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_a_cidr
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = { 
    Name = "lesson33-subnet-public-a" 
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_a_cidr
  availability_zone = "ap-northeast-1a"

  tags = { 
    Name = "lesson33-subnet-private-a" 
  }
}

# 1c
resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_c_cidr
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = { 
    Name = "lesson33-subnet-public-c" 
  }
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_c_cidr
  availability_zone = "ap-northeast-1c"

  tags = { 
    Name = "lesson33-subnet-private-c" 
  }
}

# ==========================================
# IGWの作成
# ==========================================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = { 
    Name = "lesson33-igw" 
  }
}

# ==========================================
# パブリックルートテーブルの作成
# ==========================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = { 
    Name = "lesson33-rtb-public" 
  }
}

# 0.0.0.0/0へのルートを追加
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}

# パブリックサブネットaの紐付け
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# パブリックサブネットcの紐付け
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public.id
}

# ==========================================
# プライベートルートテーブルの作成
# ==========================================
# 1a
resource "aws_route_table" "private_a" {
  vpc_id = aws_vpc.main.id

  tags = { 
    Name = "lesson33-rtb-private-a" 
  }
}

# 1c
resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.main.id

  tags = { 
    Name = "lesson33-rtb-private-c" 
  }
}

# プライベートサブネットaへの紐付け
resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

# プライベートサブネットcへの紐付け
resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_c.id
}

# ==========================================
# VPCエンドポイントの作成
# ==========================================
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private_a.id,
    aws_route_table.private_c.id
  ]

  tags = { 
    Name = "lesson33-vpce-s3" 
  }
}

# ==========================================
# ALBの作成
# ==========================================
# ALBのセキュリティグループ
resource "aws_security_group" "alb_sg" {
  name        = "lesson33-alb-sg"
  description = "Allow connection for my ALB"
  vpc_id      = aws_vpc.main.id

  # インバウンド
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # アウトバウンド
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = { 
    Name = "lesson33-alb-sg" 
  }
}

# ALBの作成
resource "aws_lb" "alb" {
  name               = "lesson33-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups    = [
    aws_security_group.alb_sg.id
  ]

  subnets            = [
    aws_subnet.public_a.id, 
    aws_subnet.public_c.id
  ]

  tags = { 
    Name = "lesson33-alb" 
  }
}

# ターゲットグループの作成
resource "aws_lb_target_group" "tg" {
  name        = "lesson33-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  # ヘルスチェック設定
  health_check {
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200,300,301"
  }

  tags = { 
    Name = "lesson33-tg" 
  }
}

# ターゲットグループのアタッチ
resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.ec2_id
  port             = 80
}

# リスナーの設定
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}