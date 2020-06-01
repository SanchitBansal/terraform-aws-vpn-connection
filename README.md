# Terraform AWS VPN Connection Module

This is Terraform module to create AWS VPN Connection with static/ dynamic routing and monitoring through cloudwatch and SNS.

**This module requires Terraform v0.11.**

Here you have the options to create:
* Create either static or dynamic VPN connection with static_routes variable
* Add routes in routing table or skip it using variable subnet_tags
* Enable or disable monitoring using variable monitoring

## VPN Connection with dynamic routing and monitoring enabled

```hcl
module "vpn_connection" {
  source                = "github.com/SanchitBansal/terraform-aws-vpn-connection.git?ref=master"
  environment           = "test"
  profile               = "nonprod"

  customer_gateway_id   = "cgw-xxxxx"
  vpn_gateway_id        = "vgw-xxxx"
  vpn_connection_name   = "Indiaoffice"

  monitoring            = "true"
  endpoint              = "https://events.pagerduty.com/integration/xxxxxxxxxxxxxxxxx/enqueue"
  endpoint_auto_confirms = "true"

  custom_tags = {
    businessunit = "techteam"
    organization = "github"
  }  
}
```

## VPN Connection with static routing and routes added in routing table too, monitoring enabled

```hcl
module "vpn_connection" {
 source                = "github.com/SanchitBansal/terraform-aws-vpn-connection.git?ref=master"
 environment           = "test"
 profile               = "nonprod"

 customer_gateway_id   = "cgw-xxxxx"
 vpn_gateway_id        = "vgw-xxxx"
 vpn_connection_name   = "Indiaoffice"

 static_routes         = ["10.0.xxx.x/24","10.0.xxx.x/24"]
 subnet_tags           = [
   {
     role = "infra"
   },
   {
     role = "db"
   }
 ]
 monitoring            = "true"
 endpoint              = "https://events.pagerduty.com/integration/xxxxxxxxxxxxxxxxx/enqueue"
 endpoint_auto_confirms = "true"
 custom_tags = {
   businessunit = "techteam"
   organization = "github"
 }
}
```

## VPN Connection with static routing and routes not added in routing table, monitoring disabled

```hcl
module "vpn_connection" {
 source                = "github.com/SanchitBansal/terraform-aws-vpn-connection.git?ref=master"
 environment           = "test"
 profile               = "nonprod"

 customer_gateway_id   = "cgw-xxxxx"
 vpn_gateway_id        = "vgw-xxxx"
 vpn_connection_name   = "Indiaoffice"

 static_routes         = ["10.0.xxx.x/24","10.0.xxx.x/24"]

 endpoint              = ""
 custom_tags = {
   businessunit = "techteam"
   organization = "github"
 }
}
```
