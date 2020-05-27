provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.profile}"
}

## Create aws vpn connection by vpn gateway id

resource "aws_vpn_connection" "connection" {
  vpn_gateway_id      = "${var.vpn_gateway_id}"
  customer_gateway_id = "${var.customer_gateway_id}"
  type                = "${var.vpn_connection_type}"
  static_routes_only  = "${length(var.static_routes) > 0 ? "true" : "false"}"

  tags = "${merge(
    map("Name", "${format("%s-%s", var.environment, var.vpn_connection_name)}"),
    map("environment", "${var.environment}"),
    var.custom_tags)
  }"
}


// Create static routes in vpn connection
resource "aws_vpn_connection_route" "connection_route" {
  destination_cidr_block = "${var.static_routes[count.index]}"
  vpn_connection_id      = "${aws_vpn_connection.connection.id}"
  count                  = "${length(var.static_routes)}"
}


// Create routes entries in route tables selected through tags
resource "aws_route" "vpn_route" {
  route_table_id         = "${data.aws_route_table.selected.*.id[floor(count.index/length(var.static_routes))]}"
  destination_cidr_block = "${element(var.static_routes, count.index)}"
  gateway_id             = "${var.vpn_gateway_id}"
  count                  = "${length(var.subnet_tags) * length(var.static_routes) * length(var.availability_zones)}"

}
