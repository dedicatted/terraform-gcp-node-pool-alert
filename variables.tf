variable "region" {
  description = "GCP region"
}

variable "zone" {
  description = "GCP zone"
}

variable "project" {
  description = "Name of GCP project"
}


variable "machine_type" {
  description = "Machine type"
}

variable "autoscaling" {
  description = "Autoscaling block"
  default     = null
}

variable "cluster_name" {
  description = "Name of GKE cluster"
}

variable "notification_channel" {
  description = "ID of your notification channel in Google Alerts"
}


