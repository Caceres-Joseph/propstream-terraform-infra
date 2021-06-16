provider "aws" {
  region = var.region
  assume_role {
    role_arn     = var.cross_role
    session_name = "DEPLOY"
  }
}
