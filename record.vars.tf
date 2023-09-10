variable "records" {
  type = list(object({
    name            = string           # The name of the record.
    type            = string           # The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
    ttl             = optional(number) # The TTL of the record.
    records         = list(string)     # A string list of records.
    health_check_id = optional(string) # The health check the record should be associated with.
    set_identifier  = optional(string) # Unique identifier to differentiate records with routing policies from one another.
    alias = optional(object({
      name                   = string           # DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone.
      zone_id                = optional(string) # Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone.
      evaluate_target_health = bool             # Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set by checking the health of the resource record set.
    }))
    cidr_routing_policy = optional(object({
      collection_id = string # The CIDR collection ID.
      location_name = string # The CIDR collection location name.
    }))
    failover_routing_policy = optional(object({
      type = string # PRIMARY or SECONDARY. A PRIMARY record will be served if its healthcheck is passing, otherwise the SECONDARY will be served.
    }))
    geolocation_routing_policy = optional(object({
      continent   = optional(string) # A two-letter continent code.
      country     = optional(string) # A two-character country code or * to indicate a default resource record set.
      subdivision = optional(string) # A subdivision code for a country.
    }))
    latency_routing_policy = optional(object({
      region = string # An AWS region from which to measure latency.
    }))
    multivalue_answer_routing_policy = optional(bool) # Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy.
    weighted_routing_policy = optional(object({
      weight = number # A numeric value indicating the relative weight of the record.
    }))
    allow_overwrite = optional(bool)   # Allow creation of this record in Terraform to overwrite an existing record, if any.
    zone_id         = optional(string) # The ID of the hosted zone to contain this record or the current one.
  }))
  description = "List of Route 53 records."
  default     = [{ name = null, type = null, records = [] }]
}
