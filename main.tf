provider "ibm" {
  bluemix_api_key    = "${var.bx_api_key}"
}

resource "ibm_container_cluster" "testacc_cluster" {
  name         = "test"
  datacenter   = "dal10"
  org_guid     = "${var.bx_org_guid}"
  space_guid   = "${var.bx_space_guid}"
  account_guid = "${var.bx_account_guid}"
  machine_type = "free"

 workers = [{
    name   = "worker1"
    action = "add"
  }]
}

variable "bx_api_key" {
  type        = "string"
  description = "Your Bluemix API key."
}

variable "bx_org_guid" {
  type        = "string"
  description = "Your Bluemix org GUID."
}

variable "data.ibm_space.space.id" {
  type        = "string"
  description = "Your Bluemix space GUID."
}

variable "bx_account_guid" {
  type        = "string"
  description = "Your Bluemix account GUID."
}

data "ibm_space" "space" {
  org   = "rvennam@us.ibm.com"
  space = "dev"
}

resource "ibm_app" "app" {
  name         = "rvennam-tf-app"
  space_guid   = "${data.ibm_space.space.id}"
  app_path     = "hello.zip"
  wait_timeout = 90
  buildpack    = "sdk-for-nodejs"
}
