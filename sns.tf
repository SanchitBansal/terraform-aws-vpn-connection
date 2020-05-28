/**
 * SNS notification configuration
 */

resource "aws_sns_topic" "topic" {
  name  = "${format("%s-%s-vpnconnection-sns", var.environment, var.vpn_connection_name)}"
  delivery_policy = "${var.delivery_policy}"
  count = "${var.monitoring == "true" ? 1 : 0}"

  tags = "${merge(
    map("environment", "${var.environment}"),
    var.custom_tags)
  }"
}

resource "aws_sns_topic_policy" "policy" {
  arn = "${aws_sns_topic.topic.arn}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "default",
  "Statement":[{
    "Sid": "default",
    "Effect": "Allow",
    "Principal": {"AWS":"*"},
    "Action": [
      "SNS:Publish"
    ],
    "Resource": "${aws_sns_topic.topic.arn}"
  }]
}
POLICY

  count = "${var.monitoring == "true" ? 1 : 0}"
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn              = "${aws_sns_topic.topic.arn}"
  protocol               = "${var.protocol}"
  endpoint               = "${var.endpoint}"
  endpoint_auto_confirms = "${var.endpoint_auto_confirms}"
  count                  = "${var.monitoring == "true" ? 1 : 0}"
}
