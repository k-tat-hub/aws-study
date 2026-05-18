# backendの定義
terraform {
  backend "s3" {
    bucket = "tf-handson-tat"
    key    = "chapter-5/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
