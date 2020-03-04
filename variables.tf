variable "pipeline_name" {
  type        = string
  description = "Unique name for pipeline. No spaces."
}

variable "acs_env" {
  type        = string
  description = "Environment of the AWS Account (e.g. dev, prd)"
}

variable "role_permissions_boundary_arn" {
  type        = string
  description = "The role permissions boundary ARN."
  default     = null
}

variable "power_builder_role_arn" {
  type        = string
  description = "The ARN for the PowerBuilder role."
  default     = null
}

//Source
variable "source_github_owner" {
  type    = string
  description = "The GitHub owner of the GitHub repo (the GitHub org or individual)."
  default = "byu-oit"
}

variable "source_github_repo" {
  type        = string
  description = "The name of the repository of the project."
}

variable "source_github_branch" {
  type        = string
  description = "The name of the branch you want to trigger the pipeline."
}

variable "source_github_token" {
  type        = string
  description = "The GitHub token associated with the AWS account."
  default     = null
}


//Build
variable "build_buildspec" {
  description = "The name (or text) of the buildspec file for the Build stage."
  type        = string
  default     = "buildspec.yml"
}

variable "build_env_variables" {
  type        = map(string)
  description = "Environment variables for Build"
  default     = {}
}

//Deploy
variable "deploy_terraform_application_path" {
  type        = string
  description = "Relative path to the terraform application folder from the root (requires trailing slash)"
}

variable "deploy_code_deploy_config" {
  type        = object({ ApplicationName = string, DeploymentGroupName = string })
  description = "Code Deploy configuration"
}

variable "required_tags" {
  type = object({ env = string, data-sensitivity = string })
}

variable "tags" {
  type        = map(string)
  description = "Extra tags to attach to the pipeline"
  default     = {}
}

variable "terraform_url" {
  type = string
  description = "URL to download terraform executable from"
  default = "https://releases.hashicorp.com/terraform/0.12.20/"
}

variable "terraform_archive_name" {
  type = string
  description = "Zipfile archive name to download Terraform"
  default = "terraform_0.12.20_linux_amd64.zip"
}

