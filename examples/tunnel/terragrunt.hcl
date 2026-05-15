# dependency "vpc" {
#   config_path  = "PATH/TO/VPC"
# }

# dependency "vpn_gateway" {
#   config_path  = "PATH/TO/vpn_gateway"
# }


terraform {
  source = "../.."
}

locals {
  vpn_gateway_id = "vpngw-89vgd7ab" #dependency.vpn_gateway.*.id
  vpn_gateway_public_ip = "43.134.0.137"  #dependency.vpn_gateway.*.ip
}

inputs = {

  create  = true
  seq_num = "001"
  region  = "ap-singapore"
  env = "p"
  local_vpc_name = "vpc_test_local"
  project = "devops"

  vpc_name = "goto-test-vpn-fz-01" #dependency.vpc.vpc_name
  department-id = "goto-devops"
  vpc_id = "vpc-fbf6gcj7" #dependency.vpc.vpc_id

  vpn_gateway_id        = local.vpn_gateway_id
  vpn_gateway_public_ip = local.vpn_gateway_public_ip

  customer_gateway_id = "cust-xxxx"
  customer_gateway_ipaddress = "192.168.2.11"

  connection_config = {
    name : "tpe"
    pre_share_key : "{Upo4t3tEP"
    ike_version : "IKEV2"
    ike_proto_encry_algorithm : "AES-CBC-256" //Proto encrypt algorithm of the IKE operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, AES128GCM128, AES192GCM128, AES256GCM128,AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC.
    ike_proto_authen_algorithm : "MD5" //  Proto authenticate algorithm of the IKE operation specification. Valid values: MD5, SHA, SHA-256. Default Value is MD5.
    ike_local_identity : "ADDRESS" // Local identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS.
    ike_exchange_mode : "MAIN" // Exchange mode of the IKE operation specification. Valid values: AGGRESSIVE, MAIN. Default value is MAIN.
    ike_remote_identity : "ADDRESS" //Remote identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS.
    ike_dh_group_name : "GROUP1" //DH group name of the IKE operation specification. Valid values: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24. Default value is GROUP1.
    ike_sa_lifetime_seconds : 86400 //SA lifetime of the IKE operation specification, unit is second. The value ranges from 60 to 604800. Default value is 86400 seconds.
    ipsec_encrypt_algorithm : "AES-CBC-128" //Encrypt algorithm of the IPSEC operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, NULL, AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC.
    ipsec_integrity_algorithm : "MD5" //Integrity algorithm of the IPSEC operation specification. Valid values: SHA1, MD5, SHA-256. Default value is MD5.
    ipsec_sa_lifetime_seconds : 3600 //SA lifetime of the IPSEC operation specification, unit is second. Valid value ranges: [ 180~604800 ]. Default value is 3600 seconds.
    ipsec_pfs_dh_group : "NULL" //PFS DH group. Valid value: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24, NULL. Default value is NULL.
    ipsec_sa_lifetime_traffic : 1843200 //A lifetime of the IPSEC operation specification, unit is KB. The value should not be less then 2560. Default value is 1843200.
    dpd_enable : 1  //Specifies whether to enable DPD. Valid values: 0 (disable) and 1 (enable).
    dpd_timeout : 30 //DPD timeout period.Valid value ranges: [ 30~60 ], Default:  30; unit: second. If the request is not responded within this period, the peer end is considered not exists. This parameter is valid when the value of DpdEnable is 1.
    dpd_action : "restart"
#    spds : [
#      {
#        local_cidr_block : "10.0.0.0/16",
#        remote_cidr_block : ["192.168.0.0/24"]
#      }
#    ]
  }


  vpn_route_configs = [
    {
      vpn_gateway_id         = local.vpn_gateway_id
      destination_cidr_block = "192.168.0.0/24"
      instance_id            = ""
      instance_type          = "VPNCONN"
      priority               = 100
      status                 = "ENABLE"
    }
  ]
}