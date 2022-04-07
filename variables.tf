variable "path_part" {
  type        = string
  description = "The path part for the endpoint."
}

variable "parent_id" {
  type        = string
  description = "The parent resource ID of the REST API in API Gateway."
}

variable "api_id" {
  type        = string
  description = "The ID of the REST API in API Gateway."
}

variable "cors" {
  type        = string
  default     = "*"
  description = "API CORS configuration."
}
