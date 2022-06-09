variable "project" {
  description = "Project or organisation name"
  type        = string
}

variable "environment" {
  description = "Application environment name (dev/prod/qa)"
  type        = string
}

variable "aws_region" {
  description = "AWS region where our resources going to create choose"
  type        = string
}

variable "costcentre" {
  description = "tag for cost"
  type        = string
}

variable "department" {
  description = "Project department name"
  type        = string
}

variable "cloudtrail-s3-bucket" {
  description = "Cloudtrail log bucket name"
  type =  string
}
