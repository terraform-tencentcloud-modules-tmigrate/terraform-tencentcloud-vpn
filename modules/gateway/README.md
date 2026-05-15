# tencentcloud_vpn_gateway

The tencentcloud_vpn_gateway resource in Tencent Cloud is used to create and manage a Virtual Private Network (VPN)
gateway. A VPN gateway is a device that establishes encrypted connections between your on-premise network and a Virtual
Private Cloud (VPC) in Tencent Cloud. By using a VPN connection, you can securely transfer data between two networks,
typically using the IPsec (Internet Protocol Security) protocol.

Key Features:

	•	Cross-cloud and on-premise connectivity: The VPN gateway allows you to create encrypted tunnels to connect your on-premises data center to your VPC network in Tencent Cloud.
	•	Supports multiple encryption protocols: The VPN gateway supports encryption protocols such as IPsec and SSL to ensure secure data transmission.
	•	High availability and automated management: VPN gateways can be configured with redundant connections for high availability and can automatically scale to support more connections as needed.

VPN Gateway:

Reference: https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_gateway

## Usage

```hcl
dependency "vpc" {
  config_path = "PATH/TO/VPC"
}

# Input variables passed to Terraform modules
inputs = {

  # vpn gateway args
  create = true
  vpc_id = dependency.vpc.vpc_id
  region = "ap-singapore"  # Example region, could be "ap-singapore" or "ap-jakarta"
  subnet_vpc_name = "goto-test-vpn-fz-01"  # The name of the VPC, used to name the gateway
  seq_num = 01           # Sequence number, used to name the gateway
  bandwidth = 10              #VPN gateway bandwidth
  zone = "ap-singapore-1"  # Replace with your regional availability zone
  type = "IPSEC"         # VPN gateway type (CCN, IPSEC)
  charge_type = "POSTPAID_BY_HOUR"  # Billing Model
  prepaid_period = 12              # Only used in prepaid mode, indicating the cycle (month)
  prepaid_renew_flag = "NOTIFY_AND_AUTO_RENEW"  # Automatic renewal sign
  max_connection = 100             # Maximum number of SSL VPN gateway connections, applicable only to SSL VPN
  tags = { "Environment" = "Test", "Name" = "test-vpn-gw" }  # Resource Tags
  vpn_id = ""
  route_table_name = "default"

  # 路由表映射配置
  patch_route_table_map = {
    "entry1" = {
      route_table_id         = dependency.vpc.route_table_id
      destination_cidr_block = "172.16.0.0/16"
      next_type = "VPN"
      #support []string{"CVM", "VPN", "DIRECTCONNECT", "PEERCONNECTION", "SSLVPN", "HAVIP", "NAT", "NORMAL_CVM", "EIP", "CCN", "LOCAL_GATEWAY"}
      next_hub               = ""
    }
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >=1.81.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >=1.81.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_route_table_entry.route_table_entry](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/route_table_entry) | resource |
| [tencentcloud_vpn_gateway.gateway](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | The bandwidth limit for the VPN gateway, typically measured in Mbps. | `number` | n/a | yes |
| <a name="input_charge_type"></a> [charge\_type](#input\_charge\_type) | The billing mode for the VPN gateway. Valid values are 'PREPAID' (for monthly or yearly billing) and 'POSTPAID\_BY\_HOUR' (for hourly billing). | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether to create the resources in this module. If true, the resources will be created; otherwise, the resources will be skipped. | `bool` | `true` | no |
| <a name="input_max_connection"></a> [max\_connection](#input\_max\_connection) | The maximum number of connections allowed for the VPN gateway. This applies to SSL VPN gateways. | `number` | n/a | yes |
| <a name="input_patch_route_table_map"></a> [patch\_route\_table\_map](#input\_patch\_route\_table\_map) | A map of route table entries to configure custom routes in the specified route tables. Each entry must include 'route\_table\_id', 'destination\_cidr\_block', 'next\_type', and 'next\_hub'. | <pre>map(object({<br>    route_table_id         = string<br>    destination_cidr_block = string<br>    next_type              = string<br>    next_hub               = string<br>  }))</pre> | `{}` | no |
| <a name="input_prepaid_period"></a> [prepaid\_period](#input\_prepaid\_period) | The prepayment period for the VPN gateway when 'charge\_type' is set to 'PREPAID'. Valid values are in months (e.g., '1', '12', '36'). | `string` | n/a | yes |
| <a name="input_prepaid_renew_flag"></a> [prepaid\_renew\_flag](#input\_prepaid\_renew\_flag) | The renewal policy for prepaid VPN gateways. Valid values are 'NOTIFY\_AND\_AUTO\_RENEW' (for automatic renewal) and 'NOTIFY\_AND\_MANUAL\_RENEW'. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region where the VPN gateway and other resources are located. Example: 'ap-jakarta'. | `string` | `"ap-jakarta"` | no |
| <a name="input_route_table_ids"></a> [route\_table\_ids](#input\_route\_table\_ids) | A map of route table IDs to be patched, referenced by a key to identify which route table to modify with custom routes. | `map(string)` | `{}` | no |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | The name of the route table to be created or modified. This name will be used to identify the route table in the network configuration. | `string` | n/a | yes |
| <a name="input_seq_num"></a> [seq\_num](#input\_seq\_num) | A sequence number appended to the VPN gateway or network resource name to ensure uniqueness. | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the VPN gateway, used to label and organize resources. Example: { 'Environment' = 'Production', 'Owner' = 'Team' }. | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of the VPN gateway to be created, such as 'CCN', 'IPSEC', etc. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC where the VPN gateway is deployed. | `string` | n/a | yes |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | A map of VPC IDs to be patched, referenced by a key to identify which VPC to use in subsequent resources or routing configurations. | `map(string)` | `{}` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the VPC subnet where the VPN gateway is located. | `string` | n/a | yes |
| <a name="input_vpn_gateways"></a> [vpn\_gateways](#input\_vpn\_gateways) | A map of VPN gateways to be created for CCN (Cloud Connect Network). This should follow the structure of the `tencentcloud_vpn_gateway` resource. | `any` | `{}` | no |
| <a name="input_vpn_id"></a> [vpn\_id](#input\_vpn\_id) | The ID of an existing VPN gateway. If provided, no new VPN gateway will be created. | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The availability zone in which the VPN gateway is deployed. Example: 'ap-jakarta-1'. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_gateway_ids"></a> [vpn\_gateway\_ids](#output\_vpn\_gateway\_ids) | vpn\_gateways |
| <a name="output_vpn_gateway_public_ips"></a> [vpn\_gateway\_public\_ips](#output\_vpn\_gateway\_public\_ips) | vpn\_gateways ips |
## Known Issues

N/A

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
