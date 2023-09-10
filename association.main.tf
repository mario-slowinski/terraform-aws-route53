resource "aws_route53_vpc_association_authorization" "vpc" {
  for_each = { for vpc in var.vpcs : vpc.vpc_id => vpc if coalesce(vpc.authorize, false) }

  vpc_id  = each.value.vpc_id
  zone_id = local.zone.id
}

resource "aws_route53_zone_association" "name" {
  provider = aws.authorized
  for_each = {
    for vpc, zone_association in aws_route53_vpc_association_authorization.vpc :
    vpc => zone_association
  }

  vpc_id  = each.value.vpc_id
  zone_id = each.value.zone_id
}
