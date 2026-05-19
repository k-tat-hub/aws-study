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

  tags = { Name = "lesson33-vpc" }
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

  tags = { Name = "lesson33-subnet-public-a" }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_a_cidr
  availability_zone = "ap-northeast-1a"

  tags = { Name = "lesson33-subnet-private-a" }
}

# 1c
resource "aws_subnet" "public_c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_public_c_cidr
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = { Name = "lesson33-subnet-public-c" }
}

resource "aws_subnet" "private_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_private_c_cidr
  availability_zone = "ap-northeast-1c"

  tags = { Name = "lesson33-subnet-private-c" }
}

# ==========================================
# IGWの作成
# ==========================================
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "lesson33-igw" }
}

# ==========================================
# パブリックルートテーブルの作成
# ==========================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "lesson33-rtb-public" }
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

  tags = { Name = "lesson33-rtb-private-a" }
}

# 1c
resource "aws_route_table" "private_c" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "lesson33-rtb-private-c" }
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

  tags = { Name = "lesson33-vpce-s3" }
}