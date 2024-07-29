provider "aws" {
  region = var.region
  default_tags {
    tags = {
      namespace = var.namespace
      project   = var.project_name
    }
  }
}
