variable "name" {
  type        = string
  description = "This is the name of the hosted zone."
  default     = null
}

variable "zone_id" {
  type        = string
  description = "The ID of already existing zone."
  default     = null
}

variable "comment" {
  type        = string
  description = "A comment for the hosted zone. Defaults to 'Managed by Terraform'."
  default     = null
}

variable "delegation_set_id" {
  type        = string
  description = "The ID of the reusable delegation set whose NS records you want to assign to the hosted zone."
  default     = null
}

variable "force_destroy" {
  type        = string
  description = "Whether to destroy all records (possibly managed outside of Terraform) in the zone when destroying the zone."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the zone."
  default     = null
}

variable "vpcs" {
  type = list(object({
    vpc_id     = string           # ID of the VPC to associate.
    vpc_region = optional(string) # Region of the VPC to associate. Defaults to AWS provider region.
    authorize  = optional(bool)   # Whether VPC authorization is required
  }))
  default = []
}
