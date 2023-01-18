resource "aws_lambda_function" "zip_lambda" {
  count = "${var.scheduler ? 1 : 0}"
  filename      = "${path.module}/shutdown.zip"
  function_name = "lambda_shutdown"
  role          = aws_iam_role.lambda_start_stop.arn
  handler       = "index.handler"
  runtime = "nodejs16.x"
  source_code_hash = filebase64sha256("${path.module}/shutdown.zip")
  environment {
    variables = {
      REGION = var.region
    }
  }
}

resource "aws_lambda_permission" "lambda_stop" {
  count = "${var.scheduler ? 1 : 0}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.zip_lambda[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.stop_shut[0].arn
}

resource "aws_lambda_permission" "lambda_start" {
  count = "${var.scheduler ? 1 : 0}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.zip_lambda[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.start_shut[0].arn
}