
terraform {
  required_providers {
    restapi = {
      source = "KirillMeleshko/restapi"
      version = "1.15.0"
    }
  }
}


provider "restapi" {
  uri                  = "http://${var.eckmstr_uri}/_snapshot"
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
  provider = restapi
  object_id = "s3repo"
  path = "/eck-ss"
  data = "{\"type\": \"s3\", \"settings\": {\"client\": \"default\", \"bucket\": \"eck-bucket\", \"base_path\": \"eck-ss/\"}}"
}
