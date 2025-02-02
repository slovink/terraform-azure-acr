output "container_registry_id" {
  value       = join("", azurerm_container_registry.main[*].id)
  description = "The ID of the Container Registry"
}

output "container_registry_login_server" {
  value       = join("", azurerm_container_registry.main[*].login_server)
  description = "The URL that can be used to log into the container registry"
}

output "container_registry_admin_username" {
  value       = var.admin_enabled == true ? join("", azurerm_container_registry.main[*].admin_username) : null
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
}

output "container_registry_admin_password" {
  value       = var.admin_enabled == true ? join("", azurerm_container_registry.main[*].admin_password) : null
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  sensitive   = true
}

output "container_registry_identity_principal_id" {
  value       = flatten(azurerm_container_registry.main[0].identity[*].principal_id)
  description = "The Principal ID for the Service Principal associated with the Managed Service Identity of this Container Registry"
}

output "container_registry_identity_tenant_id" {
  description = "The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry"
  value       = flatten(azurerm_container_registry.main[0].identity[*].tenant_id)
}

output "container_registry_scope_map_id" {
  value       = var.scope_map != null ? [for k in azurerm_container_registry_scope_map.main : k.id] : null
  description = "The ID of the Container Registry scope map"
}

output "container_registry_token_id" {
  value       = var.scope_map != null ? [for k in azurerm_container_registry_token.main : k.id] : null
  description = "The ID of the Container Registry token"
}

output "container_registry_webhook_id" {
  value       = var.container_registry_webhooks != null ? [for k in azurerm_container_registry_webhook.webhook : k.id] : null
  description = "The ID of the Container Registry Webhook"
}

output "container_registry_private_endpoint" {
  value       = var.enable_private_endpoint ? element(concat(azurerm_private_endpoint.pep[*].id, [""]), 0) : null
  description = "The ID of the Azure Container Registry Private Endpoint"
}

output "container_registry_private_dns_zone" {
  description = "DNS zone name of Azure Container Registry Private endpoints dns name records"
  value       = var.existing_private_dns_zone == null && var.enable_private_endpoint ? element(concat(azurerm_private_dns_zone.dnszone[*].name, [""]), 0) : var.existing_private_dns_zone
}

output "container_registry_private_endpoint_ip_addresses" {
  value       = var.enable_private_endpoint ? flatten(azurerm_private_endpoint.pep[0].custom_dns_configs[*].ip_addresses) : null
  description = "Azure Container Registry private endpoint IPv4 Addresses"
}

output "container_registry_private_endpoint_fqdn" {
  value       = var.enable_private_endpoint ? flatten(azurerm_private_endpoint.pep[0].custom_dns_configs[*].fqdn) : null
  description = "Azure Container Registry private endpoint FQDN Addresses"
}

output "private_dns_zone_id" {
  value       = tolist(azurerm_private_dns_zone.dnszone[*].id)
  description = "ID of private dns zone. To be used when there is existing dns zone and id is to be passed in private endpoint dns configuration group."

}
