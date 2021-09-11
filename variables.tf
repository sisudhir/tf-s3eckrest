variable "eckmstr_uri" {
  type = string
  description = "Elastic master ip and port"
  default = "192.168.1.93:32560"
}

variable "bucket_name" {
  type = string
  description = "s3 bucket name in AWS"
  default = "eck-bucket"
}

variable "base_path" {
  type = string
  description = "ECK snapshot Name"
  default = "eck-ss"
}
