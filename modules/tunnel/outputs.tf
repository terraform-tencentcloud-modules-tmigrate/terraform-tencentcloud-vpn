output "vpn_gateway_ids" {
  value = [for conn in tencentcloud_vpn_connection.connection : conn.vpn_gateway_id]
}
output "connection_names" {
  value = [for conn in tencentcloud_vpn_connection.connection : conn.name]
}


output "customer_gateway_ids" {
  value = [for conn in tencentcloud_vpn_connection.connection : conn.customer_gateway_id]
}

output "health_check_local_ips" {
  value = [for conn in tencentcloud_vpn_connection.connection : conn.health_check_local_ip]
}

output "health_check_remote_ip" {
  value = [for conn in tencentcloud_vpn_connection.connection : conn.health_check_remote_ip]
}


