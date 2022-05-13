variable "function" {
  type = any
  description = "The function that should be invoked when an event is triggered."
}

variable "source_arn" {
  type = string
  description = "The arn of the event source (e.g. DynamoDb Stream)."
}
