resource "tencentcloud_vpn_connection" "connection" {
  count = var.create ? 1 : 0
  //TODO Naming convention
  name                       = var.name
  vpc_id                     = var.vpc_id
  vpn_gateway_id             = var.vpn_gateway_id
  customer_gateway_id        = var.customer_gateway_id
  pre_share_key              = try(var.connection_config.pre_share_key, "testt")
  ike_version                = try(var.connection_config.ike_version, "IKEV1")                                                    // Version of the IKE operation specification, values: IKEV1, IKEV2. Default value is IKEV1.
  ike_proto_encry_algorithm  = try(var.connection_config.ike_proto_encry_algorithm, "3DES-CBC")                                   // Proto encrypt algorithm of the IKE operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, AES128GCM128, AES192GCM128, AES256GCM128,AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC.
  ike_proto_authen_algorithm = try(var.connection_config.ike_proto_authen_algorithm, "SHA")                                       //  Proto authenticate algorithm of the IKE operation specification. Valid values: MD5, SHA, SHA-256. Default Value is MD5.
  ike_local_identity         = try(var.connection_config.ike_local_identity, "ADDRESS")                                           // Local identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS.
  ike_exchange_mode          = try(var.connection_config.ike_exchange_mode, "AGGRESSIVE")                                         // Exchange mode of the IKE operation specification. Valid values: AGGRESSIVE, MAIN. Default value is MAIN.
  ike_local_address          = try(var.connection_config.ike_local_address, var.vpn_gateway_public_ip)                            // Local address of IKE operation specification, valid when ike_local_identity is ADDRESS, generally the value is public_ip_address of the related VPN gateway.
  ike_remote_identity        = try(var.connection_config.ike_remote_identity, "ADDRESS")                                          // Remote identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS.
  ike_remote_address         = try(var.connection_config.ike_remote_address, var.customer_gateway_ipaddress) // Remote address of IKE operation specification, valid when ike_remote_identity is ADDRESS, generally the value is public_ip_address of the related customer gateway.
  ike_dh_group_name          = try(var.connection_config.ike_dh_group_name, "GROUP2")                                             // DH group name of the IKE operation specification. Valid values: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24. Default value is GROUP1.
  ike_sa_lifetime_seconds    = try(var.connection_config.ike_sa_lifetime_seconds, 86400)                                          //  SA lifetime of the IKE operation specification, unit is second. The value ranges from 60 to 604800. Default value is 86400 seconds.
  ipsec_encrypt_algorithm    = try(var.connection_config.ipsec_encrypt_algorithm, "3DES-CBC")                                     // Encrypt algorithm of the IPSEC operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, NULL, AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC.
  ipsec_integrity_algorithm  = try(var.connection_config.ipsec_integrity_algorithm, "MD5")                                        //  Integrity algorithm of the IPSEC operation specification. Valid values: SHA1, MD5, SHA-256. Default value is MD5.
  ipsec_sa_lifetime_seconds  = try(var.connection_config.ipsec_sa_lifetime_seconds, 3600)                                         // SA lifetime of the IPSEC operation specification, unit is second. Valid value ranges: [180~604800]. Default value is 3600 seconds.
  ipsec_pfs_dh_group         = try(var.connection_config.ipsec_pfs_dh_group, "NULL")                                              // PFS DH group. Valid value: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24, NULL. Default value is NULL.
  ipsec_sa_lifetime_traffic  = try(var.connection_config.ipsec_sa_lifetime_traffic, 2560)                                         // A lifetime of the IPSEC operation specification, unit is KB. The value should not be less then 2560. Default value is 1843200.
  dpd_enable                 = try(var.connection_config.dpd_enable, 1)                                                           // Specifies whether to enable DPD. Valid values: 0 (disable) and 1 (enable).
  dpd_timeout                = try(var.connection_config.dpd_timeout, 30)                                                         // DPD timeout period.Valid value ranges: [30~60], Default: 30; unit: second. If the request is not responded within this period, the peer end is considered not exists. This parameter is valid when the value of DpdEnable is 1.
  dpd_action                 = try(var.connection_config.dpd_action, "restart")                                                   // The action after DPD timeout. Valid values: clear (disconnect) and restart (try again). It is valid when DpdEnable is 1.
  enable_health_check        = try(var.connection_config.enable_health_check, false)                                              // Whether intra-tunnel health checks are supported.
  health_check_local_ip      = try(var.connection_config.health_check_local_ip, null)                                             // Health check the address of this terminal
  health_check_remote_ip     = try(var.connection_config.health_check_remote_ip, null)                                            // Health check peer address.

  route_type = try(var.connection_config.route_type, "StaticRoute") # STATIC, StaticRoute, Policy, Bgp

  dynamic "security_group_policy" {
    for_each = try(var.connection_config.route_type, "StaticRoute") == "STATIC" ? try(var.connection_config.spds, []) : []
    content {
      local_cidr_block  = security_group_policy.value.local_cidr_block
      remote_cidr_block = security_group_policy.value.remote_cidr_block
    }
  }

  dynamic "bgp_config" {
    for_each = try(var.connection_config.route_type, "StaticRoute") == "Bgp" ? try(var.connection_config.bgp_config, []) : []
    content {
      local_bgp_ip  = bgp_config.value.local_bgp_ip
      remote_bgp_ip  = bgp_config.value.remote_bgp_ip
      tunnel_cidr = bgp_config.tunnel_cidr
    }
  }

  tags = try(var.connection_config.tags, var.tags)
}


resource "tencentcloud_vpn_gateway_route" "vpn_gateway_route" {
  count                  = var.create ? length(var.vpn_route_configs) : 0
  vpn_gateway_id         = var.vpn_route_configs[count.index].vpn_gateway_id
  destination_cidr_block = var.vpn_route_configs[count.index].destination_cidr_block
  instance_id            = join("", tencentcloud_vpn_connection.connection.*.id)            // Instance ID of the next hop
  instance_type          = try(var.vpn_route_configs[count.index].instance_type, "VPNCONN") // Next hop type (type of the associated instance). Valid values: VPNCONN (VPN tunnel) and CCN (CCN instance)
  priority               = try(var.vpn_route_configs[count.index].route_priority, 100)
  status                 = try(var.vpn_route_configs[count.index].route_status, "ENABLE") //  ENABLE: Enable Route, DISABLE: Disable Route.
}


