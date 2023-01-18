#Cloudwatch Event
resource "aws_cloudwatch_event_rule" "start_shut" {
  count = "${var.scheduler ? 1 : 0}"
  name          = "event_start_shut"
  description = "Event for call lambda for start shutdown service"
  schedule_expression = "cron(00 13 * * ? *)"
}
resource "aws_cloudwatch_event_rule" "stop_shut" {
  count = "${var.scheduler ? 1 : 0}"
  name          = "event_stop_shut"
  description = "Event for call lambda for stop shutdown service"
  schedule_expression = "cron(00 18 * * ? *)"

}
resource "aws_cloudwatch_event_target" "target_stop_shut" {
    count = "${var.scheduler ? 1 : 0}"
    target_id = "target_lambda_stop_shutdown"
    rule = aws_cloudwatch_event_rule.stop_shut[0].name
    arn = aws_lambda_function.zip_lambda[0].arn
    input = var.input_stop
}
resource "aws_cloudwatch_event_target" "target_start_shut" {
    count = "${var.scheduler ? 1 : 0}"
    target_id = "target_lambda_start_shutdown"
    rule = aws_cloudwatch_event_rule.start_shut[0].name
    arn = aws_lambda_function.zip_lambda[0].arn
    input = var.input_start
}
