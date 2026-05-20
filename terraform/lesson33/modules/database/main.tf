# ==========================================
# RDSのセキュリティグループ
# ==========================================
resource "aws_security_group" "rds_sg" {
  name        = "lesson33-rds-sg"
  description = "Allow connection from my EC2"
  vpc_id      = var.vpc_id

  # インバウンド
  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [
      var.ec2_sg_id
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
    Name = "lesson33-rds-sg" 
  }
}

# ==========================================
# DBサブネットグループの作成
# ==========================================
resource "aws_db_subnet_group" "rds" {
  name        = "lesson33-rds-subnet-group"
  description = "Subnet group for RDS"

  subnet_ids = [
    var.subnet_private_a_id,
    var.subnet_private_c_id
  ]

  tags = { 
    Name = "lesson33-rds-subnet-group" 
  }
}

# ==========================================
# RDSインスタンスの作成
# ==========================================
resource "aws_db_instance" "rds" {
  identifier     = "lesson33-rds"
  engine         = "mysql"
  engine_version = var.db_engine_version
  username       = "admin"
  db_name        = "lesson33"
  password       = var.db_password

  instance_class        = var.db_instance_class
  allocated_storage     = 20
  max_allocated_storage = 20
  storage_type          = "gp2"
  storage_encrypted     = true

  availability_zone = "ap-northeast-1a"

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  multi_az                = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 1

  # モニタリング設定
  monitoring_interval             = 60
  monitoring_role_arn             = aws_iam_role.rds_monitoring.arn
  enabled_cloudwatch_logs_exports = [
    "audit", 
    "error", 
    "general", 
    "slowquery"
  ]

  tags = { 
    Name = "lesson33-rds" 
  }
}

# ==========================================
# RDSモニタリング用IAMロール
# ==========================================
resource "aws_iam_role" "rds_monitoring" {
  name = "lesson33-rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = { 
    Name = "lesson33-rds-monitoring-role" 
  }
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_attach" {
  role       = aws_iam_role.rds_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}