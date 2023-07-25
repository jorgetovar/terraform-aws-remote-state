variable "namespace" {
  description = "Project identifier"
  default     = "jt-aws-terraform"
  type        = string
}

variable "principal_arns" {
  description = "A list of principal arn's allowed to assume the IAM role to deploy backend"
  default     = null
  type        = list(string)
}

variable "force_destroy_state" {
  description = "Force destroy the bucket containing state files?"
  default     = true
  type        = bool
}