locals {
  bucket_name    = "${var.namespace}-${var.project_name}-lambda-builds"
  lambda_package = "../${path.root}/lambda.zip"
}