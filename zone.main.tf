resource "aws_route53_zone" "name" {
  for_each = var.name != null ? toset([var.name]) : toset([])

  name              = var.name
  comment           = var.comment
  delegation_set_id = var.delegation_set_id
  force_destroy     = var.force_destroy
  tags              = var.tags

  dynamic "vpc" {
    for_each = { for vpc in var.vpcs : vpc.vpc_id => vpc if vpc.vpc_id != null && !coalesce(vpc.authorize, false) }
    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.vpc_region
    }
  }

  lifecycle {
    ignore_changes = [vpc]
  }
}
