resource "aws_ssm_parameter" "password" {
  name        = "/${var.name}/${var.environment}/initialAdminPassword"
  description = "The initialAdminPassword for ${var.name}-${var.environment}"
  type        = "String"
  value       = "initialAdminPassword"
  overwrite   = true
  tags        = merge(var.tags, local.tags)
}
