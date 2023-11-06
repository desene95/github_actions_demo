locals {
    env_config = yamldecode(file("${get_terragrunt_dir()}/../config_main.yaml"))
    resources = yamldecode(file("${get_terragrunt_dir()}/../config_env_resources.yaml"))
    
}

terraform {
    source = "/Users/damianesene/github_actions_demo/infra/modules/EC2"
}

inputs = {
    ec2_name       =   local.resources.global.EC2.test_server.ec2_name
    #node_group_name  =   local.resources.global.eks.node_group_name
    assoc_pub_ip = local.resources.global.EC2.test_server.assoc_pub_ip

}

include {
  path = find_in_parent_folders()
}