terraform {
  source = "../.."
}

inputs = {
  create  = true
  seq_num = "001"
  region  = "ap-singapore"

  vpn_customer_gateway = {
    customer_gateway_name      = "To-vpn-peer"
    customer_gateway_ipaddress = "192.168.3.11"
    tags = {
      Environment = "Production"
      Owner       = "TeamA"
    }
  }

}