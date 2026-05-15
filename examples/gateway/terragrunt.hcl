# dependency "vpc" {
#   config_path  = "PATH/TO/VPC"
# }

terraform {
  source = "../.."
}


inputs = {

  # vpn gateway args
  create = true
  vpc_id = "vpc-fbf6gcj7" #dependency.vpc.vpc_id
  region = "ap-singapore"
  vpc_name = "goto-test-vpn-fz-01"
  seq_num = "01"
  bandwidth = 10
  zone = "ap-singapore-1"
  type = "IPSEC"
  charge_type = "POSTPAID_BY_HOUR"
  prepaid_period = 12
  prepaid_renew_flag = "NOTIFY_AND_AUTO_RENEW"
  max_connection = 100
  tags = { "Environment" = "Test", "Name" = "test-vpn-gw" }
  vpn_id = ""
  route_table_name = "default"

  patch_route_table_map = {
    "entry1" = {
      route_table_id         = "rtb-jb2ryrlq" #dependency.vpc.route_table_id
      destination_cidr_block = "172.16.0.0/16"
      next_type              = "VPN"
      next_hub = ""
    }
  }
}