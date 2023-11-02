locals {
    env_config = yamldecode(file("${get_terragrunt_dir()}/../config_main.yaml"))
    resources = yamldecode(file("${get_terragrunt_dir()}/../config_env_resources.yaml"))
    
}

terraform {
    source = "/Users/damianesene/github_actions_demo/infra/modules/vpc"
}

inputs = {
    vpc_name = local.resources.global.network.vpc.vpc_name
    cidr_block = local.resources.global.network.vpc.cidr_block
}



include {
  path = find_in_parent_folders()
}