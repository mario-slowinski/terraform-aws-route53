locals {
  zone = merge({ id = var.zone_id }, one([for name, zone in aws_route53_zone.name : zone]))
}
