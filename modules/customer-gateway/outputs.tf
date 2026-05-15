output "id" {
  value = concat(tencentcloud_vpn_customer_gateway.customer_gateways.*.id, [""])[0]
}

output "ipaddress" {
  value = var.vpn_customer_gateway.customer_gateway_ipaddress
}