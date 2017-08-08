provider "ibm" {
  bluemix_api_key    = "${var.bx_api_key}"
}

variable "bx_api_key" {
  type        = "string"
  description = "Your Bluemix API key."
}

variable "bx_org_guid" {
  type        = "string"
  description = "Your Bluemix org GUID."
}

variable "bx_space_guid" {
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
  space_guid   = "${var.bx_space_guid}"
  app_path     = "hello.zip"
  buildpack    = "sdk-for-nodejs"
}
