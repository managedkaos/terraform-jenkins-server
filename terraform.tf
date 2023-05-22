terraform {
  required_version = "~> 1.4"

  backend "s3" {
    key    = "github-actions-cicd/terraform.tfstate" # the directory/file.tfstate
    bucket = "tf-state-storage-2247247w46246"         # the bucket
    region = "us-west-2"                              # the region
  }
}
