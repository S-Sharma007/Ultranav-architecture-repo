terraform {

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
    backend "s3" {
        bucket         = "spring-petclinic-terraform-state-bucket"
        key            = "terraform.tfstate"
        region         = "ap-southeast-2"
        dynamodb_table = "spring-petclinic-terraform-lock-table"
        encrypt = true
    }
}