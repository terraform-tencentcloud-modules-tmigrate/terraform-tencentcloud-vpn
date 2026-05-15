variable "create" {
  description = "The switch used to control whether the resource needs to be created."
  type        = bool
  default     = true
}

variable "name" {
  type = string
  
}

variable "local_vpc_name" {
  type        = string
  description = "local vpc name"
  default     = ""
}


variable "region" {
  type    = string
  default = "ap-jakarta"
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
  default     = "CCN"
}


variable "vpc_id" {
  type        = string
  description = "any vpc id that will be patched. Mapped by a key to be used"
  default     = ""
}


variable "vpn_gateway_id" {
  type        = string
  description = "id of the vpn gateway instance"
  default     = ""
}
variable "vpn_gateway_public_ip" {
  type        = string
  description = "ip of the vpn gateway public "
  default     = ""
}

variable "customer_gateway_id" {
  type = string
  description = "customer_gateway_id for this tunnel"
}

variable "customer_gateway_ipaddress" {
  type = string
  description = "customer_gateway_ipaddress"
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "connection_config" {
  type    = any
  default = {}
}


variable "vpn_route_configs" {
  type = list(object({
    vpn_gateway_id         = string //(Required, String, ForceNew) VPN gateway ID.
    destination_cidr_block = string //(Required, String, ForceNew) Destination IDC IP range.
    #    instance_id            = string // (Required, String, ForceNew) Instance ID of the next hop.
    instance_type = string // (Required, String, ForceNew) Next hop type (type of the associated instance). Valid values: VPNCONN (VPN tunnel) and CCN (CCN instance).
    priority      = number //(Required, Int, ForceNew) Priority. Valid values: 0 and 100.
    status        = string // (Required, String) Status. Valid values: ENABLE and DISABLE.
  }))
  default = [
    {
      vpn_gateway_id         = ""
      destination_cidr_block = ""
      #    instance_id            = ""
      instance_type = "VPNCONN" // 默认值设为 VPNCONN 或者 CCN, 视情况而定
      priority      = 100       // 默认优先级设为 100
      status        = "DISABLE" // 默认状态设为 DISABLE
    }
  ]
}