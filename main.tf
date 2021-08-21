
terraform {
  required_providers {
    restapi = {
      source = "KirillMeleshko/restapi"
      version = "1.15.0"
    }
  }
}


provider "restapi" {
  uri                  = "${master_uri}"
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
  path = "/${base_path}"
  data = "{\"type\": \"s3\", \"settings\": {\"client\": \"default\", \"bucket\": \"${s3_bucket}\", \"base_path\": \"${base_path}/\"}}"
}

resource "restapi_object" "take_snapshot" {
  depends_on = [restapi_object.create_repository]
  object_id = "s3snapshot"
  path = "/${base_path}/snapshot-2"
  data = "{\"indices\": \"index_1,index_2\",\"ignore_unavailable\": true,\"include_global_state\": false,\"metadata\": {\"taken_by\": \"elastic\",\"taken_because\": \"backup before upgrading\"}}"
}

