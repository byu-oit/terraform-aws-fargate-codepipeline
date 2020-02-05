locals {
  install_terraform = [
    "wget ${var.terraform_url}${var.terraform_archive_name}",
    "unzip ${var.terraform_archive_name}",
    "mv terraform /bin"
  ]

  run_terraform = [
    "mv *.tfvars $TERRAFORM_APPLICATION_DIR.",
    "cd $TERRAFORM_APPLICATION_DIR",
    "terraform init",
    "terraform apply -auto-approve -input=false",
    "cd $CODEBUILD_SRC_DIR"
  ]

  extract_appspec = [
    "cd $TERRAFORM_APPLICATION_DIR",
    "terraform output appspec > appspec.json 2>/dev/null",
    "mv appspec.json $CODEBUILD_SRC_DIR/.",
    "cd $CODEBUILD_SRC_DIR"
  ]

  appspec_artifacts = [
    "appspec.json"
  ]

  normal_cache = [
    "/root/cache/**/*"
  ]

  terraform_build_spec = {
    version = "0.2"
    phases = {
      install = {
        runtime-versions = merge({ docker = "18" }, var.runtimes)
        commands         = local.install_terraform
      }
      build = {
        commands = concat(
          local.run_terraform,
          var.export_appspec ? local.extract_appspec : []
        )
      }
    }
    artifacts = {
      files = concat(
        var.artifacts,
        var.export_appspec ? local.appspec_artifacts : []
      )
    }
    cache = {
      paths = local.normal_cache
    }
  }
}