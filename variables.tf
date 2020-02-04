variable "env_tag" {
  type        = string
  description = "The environment tag for the resources."
}

variable "data_sensitivity_tag" {
  type        = string
  description = "The data-sensitivity tag for the resources."
}

variable "tags" {
  type        = map(string)
  description = "Tags for code pipeline"
  default     = {}
}

variable "github_owner" {
  type    = string
  default = "byu-oit"
}

variable "github_repo" {
  type        = string
  description = "The name of the repository of the project."
}

variable "github_branch" {
  type        = string
  description = "The name of the branch you want to trigger the pipeline."
}

variable "pipeline_name" {
  type        = string
  description = "Unique name for pipeline. No spaces."
}

variable "terraform_application_path" {
  type        = string
  default     = ""
  description = "Relative path to the terraform application folder from the root (requires trailing slash)"
}

variable "build_buildspec" {
  description = "The name (or text) of the buildspec file for the Build stage."
  type        = string
  default = "buildspec.yml"
}

variable "role_permissions_boundary_arn" {
  type        = string
  description = "The role permissions boundary ARN."
  default     = null
}

variable "github_token" {
  type        = string
  description = "The GitHub token associated with the AWS account."
  default     = null
}

variable "power_builder_role_arn" {
  type        = string
  description = "The ARN for the PowerBuilder role."
  default     = null
}

variable "build_env_variables" {
  type        = map(string)
  description = "environment variables for Build"
  default     = {}
}

//TODO: Default to null? Or force thought?
variable "code_deploy_config" {
  type        = object({ ApplicationName = string, DeploymentGroupName = string })
  description = "Code Deploy configuration"
}

variable "acs_env" {
  type        = string
  description = "Environment of the AWS Account (e.g. dev, prd)"
}