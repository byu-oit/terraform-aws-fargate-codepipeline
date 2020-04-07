![Latest Version](https://img.shields.io/github/v/release/byu-oit/terraform-aws-fargate-codepipeline?sort=semver)

# Terraform AWS Fargate CodePipeline Module

Creates a CodePipeline specifically for a fargate project. The pipeline it creates has the following stages:

1. *Source*: Pulls from a source GitHub repo on a specified branch.
2. *Build*: Builds based on the specified buildspec.
3. *Terraform*: Runs `terraform init` on your application terraform configuration.
4. *Deploy*: Deploys the project using CodeDeploy

## Usage
```hcl
module "codepipeline" {
  source                        = "https://github.com/byu-oit/terraform-aws-fargate-codepipeline?ref=v0.1.0"
  pipeline_name                 = "example-pipeline"
  role_permissions_boundary_arn = module.acs.role_permissions_boundary.arn
  power_builder_role_arn        = module.acs.power_builder_role.arn
  source_github_owner           = "byu-oit"
  source_github_repo            = "example"
  source_github_branch          = "dev"
  source_github_token           = module.acs.github_token
  build_buildspec               = module.buildspec.script

  deploy_terraform_application_path = "./terraform-dev/application/"
  deploy_code_deploy_config = {
    ApplicationName     = "example-codedeploy"
    DeploymentGroupName = "example-deployment-group"
  }

  required_tags = {
    dev              = "dev"
    data-sensitivity = "internal"
  }
}
```

## Requirements
* Terraform version 0.12.16 or greater
* AWS provider version 2.42 or greater
* GitHub provider version 2.3 or greater
* Random provider version 2.2 or greater

## Inputs
| Name | Type |Description | Default |
| --- | --- | --- | --- |
| pipeline_name | string | Unique name for the pipeline. No spaces. | |
| role_permissions_boundary_arn | string | The role permissions boundary ARN. | |
| power_builder_role_arn | string | The ARN for the PowerBuilder role. | |
| source_github_owner | string | The GitHub owner of the GitHub repo (the GitHub org or individual) | |
| source_github_repo | string | The name of the repository of the project. | |
| source_github_branch | string | The name of the branch you want to trigger the pipeline. | |
| source_github_token | string | The GitHub token to pull from the GitHub repo. | null |
| build_buildspec | string | The name (or text) of the buildspec file for the Build stage. | buildspec.yml|
| build_env_variables | map(string) | Environment variables for Build | {} |
| deploy_terraform_application_path | string | Relative path to the terraform application folder from the root (requires trailing slash) | |
| deploy_code_deploy_config | [object](#deploy_code_deploy_config) | CodeDeploy configuration. | |
| required_tags | object | OIT specific required tags | |
| tags | map(string) | Extra tags to attach to the pipeline | {} |
| terraform_url | string | URL to download terraform executable from | https://releases.hashicorp.com/terraform/0.12.20/ |
| terraform_archive_name | string | Zipfile archive name to download Terraform | terraform_0.12.20_linux_amd64.zip |

### deploy_code_deploy_config
 * `ApplicationName` - (Required) CodeDeploy Application name
 * `DeploymentGroupName` - (Required) CodeDeploy Deployment Group name

## Outputs
| Name | Type | Description |
| --- | --- | --- |
| codepipeline | [object](https://www.terraform.io/docs/providers/aws/r/codepipeline.html#argument-reference) | The CodePipeline object |
