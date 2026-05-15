output "vpn_gateway_id" {
  description = "vpn_gateway id"
  value       = local.vpn_id
}

output "vpn_gateway_public_ip" {
  description = "vpn_gateway ip"
  value       = local.public_ip_address
}