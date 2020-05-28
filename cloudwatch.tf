/**
 * Module to create cloudwatch alerts through SNS for the VPN tunnel getting created
 */

resource "aws_cloudwatch_metric_alarm" "alarm" {
  alarm_name          = "${format("%s-%s-vpnconnection-alarm", var.environment, var.vpn_connection_name)}"
  comparison_operator = "${var.comparison_operator}"
  evaluation_periods  = "${var.evaluation_periods}"
  metric_name         = "TunnelState"
  namespace           = "AWS/VPN"
  period              = "${var.cloudwatch_metric_period}"
  statistic           = "${var.statistic}"
  threshold           = "${var.threshold}"

  dimensions {
    VpnId = "${aws_vpn_connection.connection.id}"
  }

  alarm_description = "${format("This is to monitor the state of aws vpn connection %s for %s vpc_id", var.vpn_connection_name, data.aws_vpn_gateway.selected.attached_vpc_id)}"
  alarm_actions     = ["${aws_sns_topic.topic.arn}"]
  ok_actions        = ["${aws_sns_topic.topic.arn}"]

  tags = "${merge(
    map("environment", "${var.environment}"),
    var.custom_tags)
  }"

  count = "${var.monitoring == "true" ? 1 : 0}"
}
