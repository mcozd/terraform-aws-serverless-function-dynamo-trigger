resource "aws_lambda_event_source_mapping" "trigger" {
  event_source_arn = var.source_arn
  function_name = var.function.arn
  maximum_retry_attempts = var.retries
  batch_size = var.batch_size
  starting_position = "LATEST"
}

data "aws_iam_policy_document" "dynamo" {
  statement {
    effect = "Allow"
    actions = [ "dynamodb:GetRecords" ]
    resources = [ var.source_arn ]
  }
}

resource "aws_iam_policy" "dynamo" {
  policy = data.aws_iam_policy_document.dynamo.json
}

resource "aws_iam_role_policy_attachment" "dynamo" {
  policy_arn = aws_iam_policy.dynamo.arn
  role = var.function.role
}
