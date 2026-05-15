resource "tencentcloud_vpn_gateway" "gateway" {
  count = var.create ? 1 : 0

  name               = var.name
  bandwidth          = try(var.bandwidth, 5)
  zone               = try(var.zone, null)
  type               = try(var.type, "IPSEC")                                                                       // CCN, IPSEC
  vpc_id             = var.vpc_id                                                                                   // Required if vpn gateway is not in CCN or SSL_CCN type, and doesn't make sense for CCN or SSL_CCN vpn gateway.
  charge_type        = try(var.charge_type, "POSTPAID_BY_HOUR")                                                     // PREPAID, POSTPAID_BY_HOUR
  prepaid_period     = try(var.charge_type, "POSTPAID_BY_HOUR") == "PREPAID" ? try(var.prepaid_period, null) : null // Period of instance to be prepaid. Valid value: 1, 2, 3, 4, 6, 7, 8, 9, 12, 24, 36. The unit is month. Caution: when this para and renew_flag para are valid, the request means to renew several months more pre-paid period. This para can only be changed on IPSEC vpn gateway.
  prepaid_renew_flag = try(var.prepaid_renew_flag, "NOTIFY_AND_AUTO_RENEW")                                         // "NOTIFY_AND_MANUAL_RENEW" //  Flag indicates whether to renew or not. Valid value: NOTIFY_AND_AUTO_RENEW, NOTIFY_AND_MANUAL_RENEW.
  max_connection     = try(var.max_connection, null)                                                                // Maximum number of connected clients allowed for the SSL VPN gateway. Valid values: [5, 10, 20, 50, 100]. This parameter is only required for SSL VPN gateways.
  tags               = var.tags
  lifecycle {
    ignore_changes = [
      charge_type // change charge type is not well supported by VPN gateway, so it is recommended not to modify it
    ]
  }
}

locals {
  vpn_id = var.create ? join("", tencentcloud_vpn_gateway.gateway.*.id) : var.vpn_id
  public_ip_address = join("", tencentcloud_vpn_gateway.gateway.*.public_ip_address)
}


resource "tencentcloud_route_table_entry" "route_table_entry" {
  for_each               = var.create ? var.patch_route_table_map : {}
  route_table_id         = each.value.route_table_id
  destination_cidr_block = each.value.destination_cidr_block
  next_type              = "VPN"
  next_hub               = local.vpn_id
  description            = ""
}