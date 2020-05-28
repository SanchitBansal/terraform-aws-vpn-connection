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

variable "monitoring" {
  type    = "string"
  default = "false"
  description = "Boolean variable to decide whether to enable monitoring through cloudwatch or not"
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

variable "evaluation_periods" {
  default = "3"
  description = "The number of periods over which data is compared to the specified threshold in cloudwatch alarm"
}

variable "cloudwatch_metric_period" {
  default = "300"
  description = "The period in seconds over which the specified statistic is applied in cloudwatch"
}

variable "statistic" {
  default = "Minimum"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
}

variable "threshold" {
  default = "1"
  description = "The value against which the specified statistic is compared"
}

variable "comparison_operator" {
  default = "LessThanThreshold"
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
}

variable "delivery_policy" {
  default = ""
  description = "The SNS delivery policy"
}

variable "protocol" {
  default = "https"
  description = "SNS topic subscription protocol, the possible values for this are: sqs, sms, lambda, application. (http or https are partially supported)"
}

variable "endpoint" {
  type = "string"
  description = "The endpoint to send data to, the contents will vary with the protocol"
}

variable "endpoint_auto_confirms" {
  default = "false"
  description = "Boolean indicating whether the end point is capable of auto confirming subscription"
}
