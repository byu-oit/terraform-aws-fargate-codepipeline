provider "aws" {
  version = "~> 2.42"
  region  = "us-west-2"
}

module "buildspec" {
  source = "github.com/byu-oit/terraform-aws-basic-codebuild-helper?ref=v0.0.2"
  ecr_repo_name = "reponame"
}

//https://docs.aws.amazon.com/codepipeline/latest/userguide/reference-pipeline-structure.html
module "codepipeline" {
  source = ".."
  pipeline_name = "parking-api-dev"
  github_repo   = "parking-v2"
  github_branch = "dev"
  acs_env = "dev"
  build_buildspec = module.buildspec.script
  terraform_application_path = "./terraform-dev/application/"
  env_tag              = "dev"
  data_sensitivity_tag = "confidential"
  code_deploy_config = {
    ApplicationName     = "parking-api-codedeploy"
    DeploymentGroupName = "parking-api-deployment-group"
  }
}
