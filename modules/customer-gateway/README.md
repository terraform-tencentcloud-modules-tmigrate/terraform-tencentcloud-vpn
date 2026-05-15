# goto-terraform-vpn-customer-gateway

Provides a resource to create a VPN customer gateway. more

Reference: https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_customer_gateway

# Customer Gateway
Reference: https://www.tencentcloud.com/document/product/1037/39685

## Usage

```hcl
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
| [tencentcloud_vpn_customer_gateway.customer_gateways](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_customer_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | The switch used to control whether the resource needs to be created. | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"ap-jakarta"` | no |
| <a name="input_seq_num"></a> [seq\_num](#input\_seq\_num) | Sequence number to be added to the network name. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpn_customer_gateway"></a> [vpn\_customer\_gateway](#input\_vpn\_customer\_gateway) | n/a | <pre>object({<br>    customer_gateway_name      = string                // Required: Name of the customer gateway.<br>    customer_gateway_ipaddress = string                // Required: Public IP address of the customer gateway.<br>    tags                       = optional(map(string)) // Optional: Tags associated with the customer gateway.<br>  })</pre> | <pre>{<br>  "customer_gateway_ipaddress": "192.168.1.1",<br>  "customer_gateway_name": "example-gateway",<br>  "tags": {<br>    "Environment": "Production",<br>    "Owner": "TeamA"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_ipaddress"></a> [ipaddress](#output\_ipaddress) | n/a |
