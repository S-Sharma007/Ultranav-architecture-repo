provider "aws" {
  region = "ap-southeast-2"  
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "spring-petclinic-terraform-state-bucket"
  acl    = "private"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_s3_bucket" "check_region" {
  bucket = aws_s3_bucket.terraform_state.id

  depends_on = [aws_s3_bucket.terraform_state]
}

output "bucket_region" {
  value = data.aws_s3_bucket.check_region.region
}

resource "aws_dynamodb_table" "statefile-lock-status" {
  name         = "spring-petclinic-terraform-lock-table"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}


