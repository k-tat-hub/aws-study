terraform {
  backend "s3" {
    bucket  = "raisetech-state-tat"
    key     = "raisetech/dev/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}