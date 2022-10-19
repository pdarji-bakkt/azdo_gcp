variable "azdo_project_id" {
  type        = string
  description = "The ID of the AzDo project"
  default     = null
}

variable "azdo_project_name" {
  type        = string
  description = "The ID of the AzDo project"
  default     = null
}

variable "secret_type" {
  type        = string
  description = "The type of the k8s secret"
  default     = "kubernetes.io/service-account-token"
}
variable "namespaces" {
  type        = list(string)
  description = "Cluster namespaces"
}

variable "AZDO_PERSONAL_ACCESS_TOKEN" {
  type        = string
  sensitive   = true
  description = "AzDo access token"
}

variable "AZDO_ORG_SERVICE_URL" {
  type        = string
  description = "AzDo URL"
  default     = "https://dev.azure.com"
}

variable "azdo_env_id" {
  type        = string
  description = "The ID of the AzDo environment"
  default     = null
}
