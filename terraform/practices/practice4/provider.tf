# provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

# backend
terraform {
  backend "s3" {
    bucket               = "tf-handson-tat"
    workspace_key_prefix = "practice4" # 環境ごとにフォルダーは切っていない
    key                  = "terraform.tfstate"
    region               = "ap-northeast-1"
  }
}