variable "function" {
  type = any
  description = "The function that should be invoked when an event is triggered."
}

variable "function_role" {
  type = any
  description = "The role of the triggered function. This is needed to attach required permissions."
}

variable "stream_arn" {
  type = string
  description = "The arn of the DynamoDb Stream."
}

variable "retries" {
  type = number
  description = "The amount of times the batch (whole or only failed ones) should be reprocessed."
  default = 0
}

variable "batch_size" {
  type = number
  description = "The number of items that should be processed in one batch."
  default = 10
}
