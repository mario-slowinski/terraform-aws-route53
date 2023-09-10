resource "aws_route53_record" "name_type" {
  for_each = {
    for record in var.records :
    "${record.name}_${record.type}" => record
    if record.name != null
  }

  name                             = each.value.name
  type                             = each.value.type
  ttl                              = each.value.ttl
  records                          = each.value.records
  allow_overwrite                  = each.value.allow_overwrite
  health_check_id                  = each.value.health_check_id
  multivalue_answer_routing_policy = each.value.multivalue_answer_routing_policy
  set_identifier                   = each.value.set_identifier
  zone_id                          = coalesce(each.value.zone_id, local.zone.id)

  dynamic "alias" {
    for_each = each.value.alias != null ? toset([each.value.alias]) : toset([])
    content {
      name                   = alias.value.name
      zone_id                = coalesce(alias.value.zone_id, local.zone.id)
      evaluate_target_health = alias.value.evaluate_target_health
    }
  }
}
