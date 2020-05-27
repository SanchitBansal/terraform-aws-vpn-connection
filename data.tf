# Get vpn gateway details with gateway id
data "aws_vpn_gateway" "selected" {
  id = "${var.vpn_gateway_id}"
}

# Get subnet ids with subnet tags and vpc_id
data "aws_subnet" "selected" {
  vpc_id = "${data.aws_vpn_gateway.selected.attached_vpc_id}"
  availability_zone = "${element(var.availability_zones, count.index)}"
  tags = "${var.subnet_tags[floor(count.index/length(var.availability_zones))]}"
  count = "${length(var.availability_zones) * length(var.subnet_tags)}"
}

# Get route table ids through subnet ids
data "aws_route_table" "selected" {
  subnet_id = "${data.aws_subnet.selected.*.id[count.index]}"
  count = "${length(var.subnet_tags) * length(var.availability_zones)}"
}
