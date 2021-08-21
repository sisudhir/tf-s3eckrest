
terraform {
  required_providers {
    restapi = {
      source = "KirillMeleshko/restapi"
      version = "1.15.0"
    }
  }
}

#variable "master_uri" {
  #type = string
  #description = "Master URL"
#}

#variable "s3_bucket_name" {
  #type = string
  #description = "S3 bucket name"
#}

#variable "base_path" {
  #type = string
  #description = "Base Path"
#}

provider "restapi" {
  uri                  = "http://192.168.1.93:31677/_snapshot"
  debug                = true
  headers              = {"Content-Type" = "application/json"}
  write_returns_object = true
  insecure             = true
  id_attribute         = "/"
  create_method        = "PUT"
  update_method        = "PUT"
  destroy_method       = "PUT"
}

resource "restapi_object" "create_repository" {
  object_id = "s3repo"
  path = "/eck-ss"
  data = "{\"type\": \"s3\", \"settings\": {\"client\": \"default\", \"bucket\": \"eck-bucket\", \"base_path\": \"eck-ss/\"}}"
}

resource "restapi_object" "take_snapshot" {
  depends_on = [restapi_object.create_repository]
  object_id = "s3snapshot"
  path = "/eck-ss/snapshot-2"
  data = "{\"indices\": \"index_1,index_2\",\"ignore_unavailable\": true,\"include_global_state\": false,\"metadata\": {\"taken_by\": \"elastic\",\"taken_because\": \"backup before upgrading\"}}"
}

