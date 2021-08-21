
terraform {
  required_providers {
    restapi = {
      source = "KirillMeleshko/restapi"
      version = "1.15.0"
    }
  }
}


provider "restapi" {
  uri                  = "var.masteruri"
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
  path = "/var.basepath"
  data = "{\"type\": \"s3\", \"settings\": {\"client\": \"default\", \"bucket\": \"var.s3bucket\", \"base_path\": \"var.basepath/\"}}"
}

resource "restapi_object" "take_snapshot" {
  depends_on = [restapi_object.create_repository]
  object_id = "s3snapshot"
  path = "/var.basepath/snapshot-2"
  data = "{\"indices\": \"index_1,index_2\",\"ignore_unavailable\": true,\"include_global_state\": false,\"metadata\": {\"taken_by\": \"elastic\",\"taken_because\": \"backup before upgrading\"}}"
}

