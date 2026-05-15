# goto-terraform-vpn-tunnel

Create VPN TUNNEL resource.

Reference: https://www.tencentcloud.com/document/product/1037/39688?has_map=1

## Usage1(Example of creating only the VPN Tunnel.)

```hcl
dependency "vpc" {
  config_path = "PATH/TO/VPC"
}

dependency "vpn_gateway" {
  config_path = "PATH/TO/vpn_gateway"
}


terraform {
  source = "../.."
}

locals {
  vpn_gateway_id        = dependency.vpn_gateway.*.id
  vpn_gateway_public_ip = dependency.vpn_gateway.*.ip
}

inputs = {

  create         = true
  seq_num        = "001"
  region         = "ap-singapore"
  env            = "p"
  local_vpc_name = "vpc_test_local"
  project        = "devops"

  vpc_name = dependency.vpc.vpc_name

  vpc_id = dependency.vpc.vpc_id

  vpn_gateway_id        = local.vpn_gateway_id
  vpn_gateway_public_ip = local.vpn_gateway_public_ip

  customer_gateway_id = dependency.customer_gateway.id
  customer_gateway_ipaddress = dependency.customer_gateway.ipaddress

  connection_config = {
    name : "tpe"
    pre_share_key : "{Upo4t3tEP"
    ike_version : "IKEV2"
    ike_proto_encry_algorithm : "AES-CBC-256"
    # Proto encrypt algorithm of the IKE operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, AES128GCM128, AES192GCM128, AES256GCM128,AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC.
    ike_proto_authen_algorithm : "MD5"
    #  Proto authenticate algorithm of the IKE operation specification. Valid values: MD5, SHA, SHA-256. Default Value is MD5.
    ike_local_identity : "ADDRESS"
    # Local identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS.
    ike_exchange_mode : "MAIN"
    # Exchange mode of the IKE operation specification. Valid values: AGGRESSIVE, MAIN. Default value is MAIN.
    ike_remote_identity : "ADDRESS"
    # Remote identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS.
    ike_dh_group_name : "GROUP1"
    # DH group name of the IKE operation specification. Valid values: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24. Default value is GROUP1.
    ike_sa_lifetime_seconds : 86400
    #  SA lifetime of the IKE operation specification, unit is second. The value ranges from 60 to 604800. Default value is 86400 seconds.
    ipsec_encrypt_algorithm : "AES-CBC-128"
    # Encrypt algorithm of the IPSEC operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, NULL, AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC.
    ipsec_integrity_algorithm : "MD5"
    #  Integrity algorithm of the IPSEC operation specification. Valid values: SHA1, MD5, SHA-256. Default value is MD5.
    ipsec_sa_lifetime_seconds : 3600
    # SA lifetime of the IPSEC operation specification, unit is second. Valid value ranges: [ 180~604800 ]. Default value is 3600 seconds.
    ipsec_pfs_dh_group : "NULL"
    # PFS DH group. Valid value: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24, NULL. Default value is NULL.
    ipsec_sa_lifetime_traffic : 1843200
    # A lifetime of the IPSEC operation specification, unit is KB. The value should not be less then 2560. Default value is 1843200.
    dpd_enable : 1 # Specifies whether to enable DPD. Valid values: 0 (disable) and 1 (enable).
    dpd_timeout : 30
    # DPD timeout period.Valid value ranges: [ 30~60 ], Default:  30; unit: second. If the request is not responded within this period, the peer end is considered not exists. This parameter is valid when the value of DpdEnable is 1.
    dpd_action : "restart"
#    spds : [
#      {
#        local_cidr_block : "10.0.0.0/16",
#        remote_cidr_block : ["192.168.0.0/24"]
#      }
#    ],

  }

  vpn_route_config = [
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
| [tencentcloud_vpn_connection.connection](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_connection) | resource |
| [tencentcloud_vpn_gateway_route.vpn_gateway_route](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_gateway_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_config"></a> [connection\_config](#input\_connection\_config) | n/a | `any` | `{}` | no |
| <a name="input_create"></a> [create](#input\_create) | The switch used to control whether the resource needs to be created. | `bool` | `true` | no |
| <a name="input_customer_gateway_id"></a> [customer\_gateway\_id](#input\_customer\_gateway\_id) | customer\_gateway\_id for this tunnel | `string` | n/a | yes |
| <a name="input_customer_gateway_ipaddress"></a> [customer\_gateway\_ipaddress](#input\_customer\_gateway\_ipaddress) | customer\_gateway\_ipaddress | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | set env value,Example: p\|u\|s\|d | `string` | n/a | yes |
| <a name="input_local_vpc_name"></a> [local\_vpc\_name](#input\_local\_vpc\_name) | local vpc name | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | project info | `string` | `0` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |
| <a name="input_seq_num"></a> [seq\_num](#input\_seq\_num) | Sequence number to be added to the network name. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | any vpc id that will be patched. Mapped by a key to be used | `string` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | vpc name | `string` | `"CCN"` | no |
| <a name="input_vpn_gateway_id"></a> [vpn\_gateway\_id](#input\_vpn\_gateway\_id) | id of the vpn gateway instance | `string` | `""` | no |
| <a name="input_vpn_gateway_public_ip"></a> [vpn\_gateway\_public\_ip](#input\_vpn\_gateway\_public\_ip) | ip of the vpn gateway public | `string` | `""` | no |
| <a name="input_vpn_route_configs"></a> [vpn\_route\_configs](#input\_vpn\_route\_configs) | n/a | <pre>list(object({<br>    vpn_gateway_id         = string //(Required, String, ForceNew) VPN gateway ID.<br>    destination_cidr_block = string //(Required, String, ForceNew) Destination IDC IP range.<br>    #    instance_id            = string // (Required, String, ForceNew) Instance ID of the next hop.<br>    instance_type = string // (Required, String, ForceNew) Next hop type (type of the associated instance). Valid values: VPNCONN (VPN tunnel) and CCN (CCN instance).<br>    priority      = number //(Required, Int, ForceNew) Priority. Valid values: 0 and 100.<br>    status        = string // (Required, String) Status. Valid values: ENABLE and DISABLE.<br>  }))</pre> | <pre>[<br>  {<br>    "destination_cidr_block": "",<br>    "instance_type": "VPNCONN",<br>    "priority": 100,<br>    "status": "DISABLE",<br>    "vpn_gateway_id": ""<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_names"></a> [connection\_names](#output\_connection\_names) | n/a |
| <a name="output_customer_gateway_ids"></a> [customer\_gateway\_ids](#output\_customer\_gateway\_ids) | n/a |
| <a name="output_health_check_local_ips"></a> [health\_check\_local\_ips](#output\_health\_check\_local\_ips) | n/a |
| <a name="output_health_check_remote_ip"></a> [health\_check\_remote\_ip](#output\_health\_check\_remote\_ip) | n/a |
| <a name="output_vpn_gateway_ids"></a> [vpn\_gateway\_ids](#output\_vpn\_gateway\_ids) | n/a |
## Known Issues

N/A

## Changelog

See [CHANGELOG.md](CHANGELOG.md)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)
