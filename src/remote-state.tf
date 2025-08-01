module "vpc" {
  source  = "cloudposse/stack-config/yaml//modules/remote-state"
  version = "1.8.0"

  component = var.vpc_component_name

  context = module.this.context
}

module "eks" {
  source  = "cloudposse/stack-config/yaml//modules/remote-state"
  version = "1.8.0"

  for_each = local.eks_security_group_enabled ? var.eks_component_names : toset([])

  component = each.key

  context = module.this.context
}

module "dns_delegated" {
  source  = "cloudposse/stack-config/yaml//modules/remote-state"
  version = "1.8.0"

  component   = var.dns_delegated_component_name
  environment = "gbl"

  context = module.this.context
}

module "vpc_ingress" {
  source  = "cloudposse/stack-config/yaml//modules/remote-state"
  version = "1.8.0"

  for_each = toset(var.allow_ingress_from_vpc_stages)

  component = var.vpc_ingress_component_name
  stage     = each.key

  context = module.this.context
}
