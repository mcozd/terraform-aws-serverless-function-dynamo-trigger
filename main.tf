locals {
  bisect_on_failure = var.bisect_on_failure && var.batch_size > 1
}

resource "aws_lambda_event_source_mapping" "trigger" {
  event_source_arn = var.source_arn
  function_name = var.function.arn
  maximum_retry_attempts = var.retries
  batch_size = var.batch_size
  maximum_batching_window_in_seconds = var.batch_time
  starting_position = "LATEST"
  bisect_batch_on_function_error = local.bisect_on_failure
}

data "aws_iam_policy_document" "dynamo" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetRecords",
      "dynamodb:DescribeStream",
      "dynamodb:ListStreams",
      "dynamodb:GetShardIterator" ]
    resources = [ var.source_arn ]
  }
}

resource "aws_iam_policy" "dynamo" {
  policy = data.aws_iam_policy_document.dynamo.json
}

resource "aws_iam_role_policy_attachment" "dynamo" {
  policy_arn = aws_iam_policy.dynamo.arn
  role = var.function_role.name
}
