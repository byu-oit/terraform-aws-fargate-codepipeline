provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

provider "github" {
  version      = "~> 2.6.1"
  organization = "byu-oit"
  token        = module.acs.github_token
}

module "acs" {
  source = "github.com/byu-oit/terraform-aws-acs-info.git?ref=v2.0.0"
}

module "buildspec" {
  source        = "github.com/byu-oit/terraform-aws-basic-codebuild-helper?ref=v0.0.2"
  ecr_repo_name = "reponame"
}

//https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html
module "codepipeline" {
  source                        = "./.."
  pipeline_name                 = "parking-api-dev"
  role_permissions_boundary_arn = module.acs.role_permissions_boundary.arn
  power_builder_role_arn        = module.acs.power_builder_role.arn
  source_github_owner           = "byu-oit"
  source_github_repo            = "parking-v2"
  source_github_branch          = "dev"
  source_github_token           = module.acs.github_token
  build_buildspec               = module.buildspec.script

  deploy_terraform_application_path = "./terraform-dev/application/"
  deploy_code_deploy_config = {
    ApplicationName     = "parking-api-codedeploy"
    DeploymentGroupName = "parking-api-deployment-group"
  }

  required_tags = {
    env              = "dev"
    data-sensitivity = "internal"
  }
}
