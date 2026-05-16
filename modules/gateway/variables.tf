variable "create" {
  description = "Whether to create the resources in this module. If true, the resources will be created; otherwise, the resources will be skipped."
  type        = bool
  default     = true
}

variable "name" {
  type = string
}

variable "bandwidth" {
  description = "The bandwidth limit for the VPN gateway, typically measured in Mbps."
  type        = number
  default = 100
}

variable "zone" {
  description = "The availability zone in which the VPN gateway is deployed. Example: 'ap-jakarta-1'."
  type        = string
}

variable "type" {
  description = "The type of the VPN gateway to be created, such as 'CCN', 'IPSEC', etc."
  type        = string
  default = "CCN"
}

variable "vpn_id" {
  description = "The ID of an existing VPN gateway. If provided, no new VPN gateway will be created."
  type        = string
  default = ""
}

variable "vpc_name" {
  description = "The name of the VPC subnet where the VPN gateway is located."
  type        = string
  default = "CCN"
}

variable "max_connection" {
  description = "The maximum number of connections allowed for the VPN gateway. This applies to SSL VPN gateways."
  type        = number
  default = 100
}

variable "vpc_id" {
  description = "The ID of the VPC where the VPN gateway is deployed."
  type        = string
  default = ""
}

variable "region" {
  description = "The region where the VPN gateway and other resources are located. Example: 'ap-jakarta'."
  type        = string
}

variable "vpn_gateways" {
  description = "A map of VPN gateways to be created for CCN (Cloud Connect Network). This should follow the structure of the `tencentcloud_vpn_gateway` resource."
  type        = any
  default     = {}
}

variable "vpc_ids" {
  description = "A map of VPC IDs to be patched, referenced by a key to identify which VPC to use in subsequent resources or routing configurations."
  type        = map(string)
  default     = {}
}

variable "route_table_ids" {
  description = "A map of route table IDs to be patched, referenced by a key to identify which route table to modify with custom routes."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to apply to the VPN gateway, used to label and organize resources. Example: { 'Environment' = 'Production', 'Owner' = 'Team' }."
  type        = map(string)
  default     = {}
}

variable "charge_type" {
  description = "The billing mode for the VPN gateway. Valid values are 'PREPAID' (for monthly or yearly billing) and 'POSTPAID_BY_HOUR' (for hourly billing)."
  type        = string
  default = "POSTPAID_BY_HOUR"
}

variable "prepaid_period" {
  description = "The prepayment period for the VPN gateway when 'charge_type' is set to 'PREPAID'. Valid values are in months (e.g., '1', '12', '36')."
  type        = string
  default = null
}

variable "prepaid_renew_flag" {
  description = "The renewal policy for prepaid VPN gateways. Valid values are 'NOTIFY_AND_AUTO_RENEW' (for automatic renewal) and 'NOTIFY_AND_MANUAL_RENEW'."
  type        = string
  default = null
}

variable "patch_route_table_map" {
  description = "A map of route table entries to configure custom routes in the specified route tables. Each entry must include 'route_table_id', 'destination_cidr_block', 'next_type', and 'next_hub'."
  type = map(object({
    route_table_id         = string
    destination_cidr_block = string
    next_type              = string
    next_hub               = string
  }))
  default = {}
}