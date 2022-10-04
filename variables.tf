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

  validation {
    condition = var.retries >= 0
    error_message = "The number of retries cannot be negative."
  }
}

variable "batch_size" {
  type = number
  description = "The number of items that should be processed in one batch."
  default = 10

  validation {
    condition = var.batch_size > 0
    error_message = "The batch size cannot be negative and must be greather then zero."
  }
}

variable "batch_time" {
  type = number
  description = "The maximum amount of time in seconds to wait before records will be send to your function automatically. Either the batch size or the batch time has to bea reached for your function to be invoked."
  default = 0

  validation {
    condition = var.batch_time >= 0 && var.batch_time <= 300
    error_message = "The max. amount of time for batches must be between 0 and 300 seconds."
  }
}

variable "bisect_on_failure" {
  type = bool
  description = "Splits the batch in half and retries every part separately. This can lead to better error handling, because the failed records can be split into their own batches and the function will likely get batches with working records, so that a failure does not affect the whole batch size. Works only when the batch size is greater then 1."
  default = false
}
