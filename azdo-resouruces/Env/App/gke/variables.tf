variable "project_id" {
  description = "ID of the GCP Project to host the GKE cluster in."
  type        = string
}

variable "name" {
  type        = string
  description = "Name of the GKE cluster."
}

variable "network" {
  type        = string
  description = "The VPC network to host the GKE cluster in."
}

variable "network_project_id" {
  type        = string
  description = "The GCP Project ID of the Shared VPC's Host Project; for Shared VPC Support."
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the GKE cluster in."
}

variable "ip_range_pods_cidr" {
  type        = string
  description = "The name of the secondary subnet IP range to use for the GKE Pods."
}

variable "ip_range_services_cidr" {
  type        = string
  description = "The name of the secondary subnet IP range to use for the GKE Services."
}

variable "region" {
  type        = string
  description = "Region to host the GKE cluster in. This element is optional if spinning a zonal cluster and required if spinning a regional GKE cluster."
}

# variable "zones" {
#   type        = list(string)
#   description = "The zones to host the cluster in. This element is optional if spinning a regional cluster and required if spinning a zonal GKE cluster."
# }

variable "master_ipv4_cidr_block" {
  type        = string
  description = "[Beta] The IP range in CIDR notation to use for the hosted master network."
}

variable "namespaces" {
  type        = list(string)
  description = "Cluster namespaces"
}

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

variable "AZDO_ORG_SERVICE_URL" {
  type        = string
  description = "AzDo URL"
  default     = "https://dev.azure.com"
}

variable "AZDO_PERSONAL_ACCESS_TOKEN" {
  type        = string
  description = "AzDo PAT"
  default     = null
}
