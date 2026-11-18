variable "project_name" {
  description = "s3 bucket hosting a static website through cloud front"
  type        = string
  default     = "s3-static-web-hosting"
}

variable "envirnoment" {
  description = "type of environment"
  type        = string
  default     = "dev"
}