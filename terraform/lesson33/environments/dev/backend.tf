terraform {
  backend "s3" {
    bucket  = "lesson33-state-tat"
    key     = "lesson33/dev/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}