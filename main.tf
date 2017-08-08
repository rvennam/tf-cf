provider "ibm" {
  bluemix_api_key    = "${var.bx_api_key}"
}

variable "bx_api_key" {
  type        = "string"
  description = "Your Bluemix API key."
}

variable "bx_space_guid" {
  type        = "string"
  description = "Your Bluemix space GUID."
}

data "ibm_app_route" "route" {
  domain_guid = "${data.ibm_app_domain_shared.domain.id}"
  space_guid  = "${data.ibm_space.spacedata.id}"
  host        = "rvennam-tf-cf"
}

data "ibm_space" "space" {
  org   = "rvennam@us.ibm.com"
  space = "dev"
}

resource "ibm_app" "app" {
  name         = "rvennam-tf-app"
  space_guid   = "${var.bx_space_guid}"
  app_path     = "hello.zip"
  buildpack    = "sdk-for-nodejs"
  route_guid   = ["rvennam-tf-cftest.mybluemix.net"]
}

data "ibm_app_domain_shared" "domain" {
  name = "mybluemix.net"
}

data "ibm_space" "spacedata" {
  space = "dev"
  org   = "rvennam@us.ibm.com"
}
