
terraform {
  required_providers {
    restapi = {
      source = "KirillMeleshko/restapi"
      version = "1.15.0"
    }
  }
}


provider "restapi" {
  uri                  = "http://192.168.1.93:32560/_snapshot/eck-ss"
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
  path = ""
  data = "{\"type\": \"s3\", \"settings\": {\"client\": \"default\", \"bucket\": \"eck-bucket\", \"base_path\": \"eck-ss/\"}}"
}

resource "restapi_object" "create_policy" {
  depends_on = [restapi_object.create_repository]
  object_id = "sspolicy"
  path = "_slm/policy/daily-snapshots"
  data = "\"name\":\"weather-data\",\"snapshotName\":\"weather-data-policy1\",\"schedule\":\"0 0 0 * * ?\",\"repository\":\"eck-ss\",\"config\":{\"indices\":[\"weather-data-2016\"]},\"retention\":{\"expireAfterUnit\":\"d\"},\"isManagedPolicy\":false}"
}

#resource "restapi_object" "take_snapshot" {
  #depends_on = [restapi_object.create_repository]
  #object_id = "s3snapshot"
  #path = "/eck-ss/snapshot_1"
  #data = "{\"indices\": \"index_1,index_2\",\"ignore_unavailable\": true,\"include_global_state\": false,\"metadata\": {\"taken_by\": \"elastic\",\"taken_because\": \"backup before upgrading\"}}"
#}

