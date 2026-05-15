variable "create" {
  description = "The switch used to control whether the resource needs to be created."
  type        = bool
  default     = true
}

variable "region" {
  type    = string
  default = "ap-jakarta"
}

variable "seq_num" {
  description = "Sequence number to be added to the network name."
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpn_customer_gateway" {
  type = object({
    customer_gateway_name      = string                // Required: Name of the customer gateway.
    customer_gateway_ipaddress = string                // Required: Public IP address of the customer gateway.
    tags                       = optional(map(string)) // Optional: Tags associated with the customer gateway.
  })
  default = {
    customer_gateway_name      = "example-gateway"
    customer_gateway_ipaddress = "192.168.1.1"
    tags = {
      Environment = "Production"
      Owner       = "TeamA"
    }
  }
}
