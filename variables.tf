variable "credential_path" {
  description = "path to credential file"
  type = string

  default = "credentials.json"
}

variable "project_name" {
  description = "name of project in GCP"
  type = string

  default = "intro-to-cloud-alk-kw"
}

variable "region_name" {
  description = "region name to project in GCP"
  type = string

  default = "europe-central2"
}

variable "zone_name" {
  description = "zone name to project in GCP"
  type = string

  default = "europe-central2-a"
}

variable "alk_login" {
  description = "student login in ALK"
  type = string

  default = "60485-ckp"
}

variable "vm_count" {
  description = "count of virtual machines to create"
  type = number

  default = 1
}