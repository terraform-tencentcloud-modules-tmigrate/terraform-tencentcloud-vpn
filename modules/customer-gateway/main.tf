
resource "tencentcloud_vpn_customer_gateway" "customer_gateways" {
  count = var.create ? 1 : 0
  name              = var.vpn_customer_gateway.customer_gateway_name
  public_ip_address = var.vpn_customer_gateway.customer_gateway_ipaddress
  tags              = try(var.vpn_customer_gateway.tags, var.tags)
}

 