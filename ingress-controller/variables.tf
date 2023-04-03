variable "ingress_release_name" {
  type        = string
  description = "Name of helm release"
  default     = "ingress-nginx"
}
variable "ingress_namespace" {
  type        = string
  description = "Name of namespace where nginx controller should be deployed"
  default     = "public-nginx"
}

variable "ingress_chart_version" {
  type        = string
  description = "HELM Chart Version for nginx controller"
  default     = "4.5.2"
}

variable "ingress_class_name" {
  type        = string
  description = "IngressClass resource name"
  default     = "nginx"
}

variable "ingress_class_is_default" {
  type        = bool
  description = "IngressClass resource default for cluster"
  default     = true
}

variable "ingress_ip_address" {
  type        = string
  description = "External Static Address for loadbalancer (Doesn't work with AWS)"
  default = "192.9.9.1"

}

variable "ingress_create_namespace" {
  type        = bool
  description = "Create a namespace"
  default     = true
}

variable "ingress_wait" {
  description = "Will wait until all resources are in a ready state"
  type        = bool
  default     = true
}

variable "ingress_timeout" {
  type        = number
  description = "Time in seconds to wait for any individual kubernetes operation"
  default     = 300
}

variable "elb_id" {
  type        = string
  description = "Elb id"
  default = "aaa"
}

