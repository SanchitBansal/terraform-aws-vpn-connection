variable "profile" {
  description = "profile name to get valid credentials of account"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "ap-south-1"
}

variable "environment" {
  description = "the name of your environment"
}

variable "custom_tags" {
  type        = "map"
  default     = {}
  description = "map of tags to be added"
}

variable "vpn_connection_type" {
  default = "ipsec.1"
}

variable "vpn_connection_name" {
  type = "string"
}

variable "customer_gateway_id" {
  type = "string"
}

variable "static_routes" {
  type = "list"
  description = "list of routes to define in route tables as well as static_routes of vpn connection"
  default = []
}

variable "subnet_tags" {
  type = "list"
  default = []
  description = "list of map of subnet tags to add routes, each pair of which must exactly match a pair on the desired subnet."
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = "list"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "vpn_gateway_id" {
  type = "string"
  description = "Specify which VPN Gateway the VPN Connection will be associated with"
}
