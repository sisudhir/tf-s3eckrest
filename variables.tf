variable "eckmstr_uri" {
  type = string
  description = "Elastic master URI"
}

variable "bucket_name" {
  type = string
  description = "s3 bucket name in AWS"
}

variable "base_path" {
  type = string
  description = "ECK snapshot Name"
}
