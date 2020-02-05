variable "artifacts" {
  type = list(string)
  default = []
}

variable "runtimes" {
  type    = map(string)
  default = {}
}

variable "export_appspec" {
  type    = bool
  default = false
}

variable "terraform_url" {
  type = string
  default = "https://releases.hashicorp.com/terraform/0.12.20/"
}

variable "terraform_archive_name" {
  type = string
  default = "terraform_0.12.20_linux_amd64.zip"
}