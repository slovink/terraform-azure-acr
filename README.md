<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform Azure Acr
</h1>

<p align="center" style="font-size: 1.2rem;">
    Terraform module to create Acr resource on Azure.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.7.4-green" alt="Terraform">
</a>
<a href="https://github.com/slovink/terraform-azure-acr/blob/master/LICENSE">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>


## Prerequisites

This module has a few dependencies:

- [Terraform 1.x.x](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/slovink/terraform-azure-acr).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
  ```hcl
module "container-registry" {
  source                          = "https://github.com/slovink/terraform-azure-acr.git?ref=1.0.0"
  resource_group_name             = module.resource_group.resource_group_name
  location                        = module.resource_group.resource_group_location
  container_registry_config = {
    name                          = "containerregistrydemoproject01"
    admin_enabled                 = true
    sku                           = "Premium"
    public_network_access_enabled = false
  }

  retention_policy = {
    days    = 10
    enabled = true
  }
  enable_content_trust          = true
  enable_private_endpoint       = true
  virtual_network_name          = module.vnet.vnet_name
  virtual_network_id            = join("", module.vnet.vnet_id)
  subnet_id                     = module.name_specific_subnet.specific_subnet_id
  private_subnet_address_prefix = module.name_specific_subnet.specific_subnet_address_prefixes
  private_dns_name              = "privatelink.azurecr.io" # To be same for all ACR.

}

 ```
## With existing dns in diff rg
Here is an example of how you can use this module in your inventory structure:
  ```hcl
module "acr" {
  source              = "https://github.com/slovink/terraform-azure-acr.git?ref=1.0.0"
  name                = local.name
  environment         = local.environment
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  container_registry_config = {
    name = "al86h" # Name of Container Registry
    sku  = "Premium"
  }

  virtual_network_id = module.vnet.id
  subnet_id          = [module.subnet.default_subnet_id]

  existing_private_dns_zone                     = data.azurerm_private_dns_zone.existing.name # Name of private dns zone remain same for acr.
  existing_private_dns_zone_id                  = data.azurerm_private_dns_zone.existing.id
  existing_private_dns_zone_resource_group_name = data.azurerm_resource_group.existing.name
}
 ```
## With existing dns in diff subs
Here is an example of how you can use this module in your inventory structure:
  ```hcl
module "acr" {
  source              = "https://github.com/slovink/terraform-azure-acr.git?ref=1.0.0"
  name                = local.name # Name used for specifying tags and other resources naming.(like private endpoint, vnet-link etc)
  environment         = local.environment
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  container_registry_config = {
    name = "diffacr1234" # Name of Container Registry
    sku  = "Premium"
  }

  virtual_network_id = module.vnet.id
  subnet_id          = [module.subnet.default_subnet_id]


  diff_sub                                      = true
  alias_sub                                     = "xxxxxxxxxxxxxxxxxxxx"   # Subcription id in which dns zone is present.
  existing_private_dns_zone                     = "privatelink.azurecr.io" # Name of private dns zone remain same for acr.
  existing_private_dns_zone_id                  = "/subscriptions/08xxxxxxxxxxxxxxx9c0c/resourceGroups/app-test-resource-group/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"
  existing_private_dns_zone_resource_group_name = "app-test-resource-group"
}
```

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/slovink/terraform-azure-acr/blob/krishan/LICENSE) file for details.


## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/slovink/terraform-azure-acr/tree/dev/_example) directory within this repository.


## Feedback
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/slovink/terraform-azure-acr), or feel free to drop us an email at [contact@slovink.com](contact@slovink.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/slovink/terraform-azure-acr)!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.7.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.87.0 |
| <a name="provider_azurerm.peer"></a> [azurerm.peer](#provider\_azurerm.peer) | >=3.87.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git@github.com:slovink/terraform-azure-labels.git | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_container_registry_scope_map.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_scope_map) | resource |
| [azurerm_container_registry_token.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_token) | resource |
| [azurerm_container_registry_webhook.webhook](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry_webhook) | resource |
| [azurerm_private_dns_zone.dnszone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.addon_vent_link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vent-link-diff_sub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vent-link-multi-subs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone_virtual_network_link.vent-link-same-sub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_endpoint.pep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addon_vent_link"></a> [addon\_vent\_link](#input\_addon\_vent\_link) | The name of the addon vnet | `bool` | `false` | no |
| <a name="input_addon_virtual_network_id"></a> [addon\_virtual\_network\_id](#input\_addon\_virtual\_network\_id) | The name of the addon vnet link vnet id | `string` | `""` | no |
| <a name="input_admin_enabled"></a> [admin\_enabled](#input\_admin\_enabled) | To enable of disable admin access | `bool` | `true` | no |
| <a name="input_alias_sub"></a> [alias\_sub](#input\_alias\_sub) | Subscription id for different sub in which dns zone is present. | `string` | `null` | no |
| <a name="input_container_registry_config"></a> [container\_registry\_config](#input\_container\_registry\_config) | Manages an Azure Container Registry | <pre>object({<br>    name                      = string<br>    sku                       = optional(string)<br>    quarantine_policy_enabled = optional(bool)<br>    zone_redundancy_enabled   = optional(bool)<br>  })</pre> | n/a | yes |
| <a name="input_container_registry_webhooks"></a> [container\_registry\_webhooks](#input\_container\_registry\_webhooks) | Manages an Azure Container Registry Webhook | <pre>map(object({<br>    service_uri    = string<br>    actions        = list(string)<br>    status         = optional(string)<br>    scope          = string<br>    custom_headers = map(string)<br>  }))</pre> | `null` | no |
| <a name="input_diff_sub"></a> [diff\_sub](#input\_diff\_sub) | Flag to tell whether dns zone is in different sub or not. | `bool` | `false` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Flag to control module creation. | `bool` | `true` | no |
| <a name="input_enable_content_trust"></a> [enable\_content\_trust](#input\_enable\_content\_trust) | Boolean value to enable or disable Content trust in Azure Container Registry | `bool` | `true` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Manages a Private Endpoint to Azure Container Registry | `bool` | `true` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Encrypt registry using a customer-managed key | <pre>object({<br>    key_vault_key_id   = string<br>    identity_client_id = string<br>  })</pre> | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_existing_private_dns_zone"></a> [existing\_private\_dns\_zone](#input\_existing\_private\_dns\_zone) | Name of the existing private DNS zone | `string` | `null` | no |
| <a name="input_existing_private_dns_zone_id"></a> [existing\_private\_dns\_zone\_id](#input\_existing\_private\_dns\_zone\_id) | ID of existing private dns zone. To be used in dns configuration group in private endpoint. | `string` | `null` | no |
| <a name="input_existing_private_dns_zone_resource_group_name"></a> [existing\_private\_dns\_zone\_resource\_group\_name](#input\_existing\_private\_dns\_zone\_resource\_group\_name) | The name of the existing resource group | `string` | `null` | no |
| <a name="input_georeplications"></a> [georeplications](#input\_georeplications) | A list of Azure locations where the container registry should be geo-replicated | <pre>list(object({<br>    location                = string<br>    zone_redundancy_enabled = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned. This is required when `type` is set to `UserAssigned` or `SystemAssigned, UserAssigned` | `any` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table' | `string` | `""` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'slovink'. | `string` | `"slovink"` | no |
| <a name="input_multi_sub_vnet_link"></a> [multi\_sub\_vnet\_link](#input\_multi\_sub\_vnet\_link) | Flag to control creation of vnet link for dns zone in different subscription | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_network_rule_set"></a> [network\_rule\_set](#input\_network\_rule\_set) | Manage network rules for Azure Container Registries | <pre>object({<br>    default_action = optional(string)<br>    ip_rule = optional(list(object({<br>      ip_range = string<br>    })))<br>    virtual_network = optional(list(object({<br>      subnet_id = string<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_private_dns_name"></a> [private\_dns\_name](#input\_private\_dns\_name) | n/a | `string` | `"privatelink.azurecr.io"` | no |
| <a name="input_private_dns_zone_vnet_link_registration_enabled"></a> [private\_dns\_zone\_vnet\_link\_registration\_enabled](#input\_private\_dns\_zone\_vnet\_link\_registration\_enabled) | (Optional) Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? | `bool` | `true` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | To denied public access | `bool` | `false` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/slovink/terraform-azure-acr"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `string` | `""` | no |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Set a retention policy for untagged manifests | <pre>object({<br>    days    = optional(number)<br>    enabled = optional(bool)<br>  })</pre> | <pre>{<br>  "days": 10,<br>  "enabled": true<br>}</pre> | no |
| <a name="input_same_vnet"></a> [same\_vnet](#input\_same\_vnet) | Variable to be set when multiple acr having common DNS in same vnet. | `bool` | `false` | no |
| <a name="input_scope_map"></a> [scope\_map](#input\_scope\_map) | Manages an Azure Container Registry scope map. Scope Maps are a preview feature only available in Premium SKU Container registries. | <pre>map(object({<br>    actions = list(string)<br>  }))</pre> | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet to be used for private endpoint | `list(string)` | `null` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | Virtual Network to be used for private endpoint | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_admin_password"></a> [container\_registry\_admin\_password](#output\_container\_registry\_admin\_password) | The Username associated with the Container Registry Admin account - if the admin account is enabled. |
| <a name="output_container_registry_admin_username"></a> [container\_registry\_admin\_username](#output\_container\_registry\_admin\_username) | The Username associated with the Container Registry Admin account - if the admin account is enabled. |
| <a name="output_container_registry_id"></a> [container\_registry\_id](#output\_container\_registry\_id) | The ID of the Container Registry |
| <a name="output_container_registry_identity_principal_id"></a> [container\_registry\_identity\_principal\_id](#output\_container\_registry\_identity\_principal\_id) | The Principal ID for the Service Principal associated with the Managed Service Identity of this Container Registry |
| <a name="output_container_registry_identity_tenant_id"></a> [container\_registry\_identity\_tenant\_id](#output\_container\_registry\_identity\_tenant\_id) | The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry |
| <a name="output_container_registry_login_server"></a> [container\_registry\_login\_server](#output\_container\_registry\_login\_server) | The URL that can be used to log into the container registry |
| <a name="output_container_registry_private_dns_zone"></a> [container\_registry\_private\_dns\_zone](#output\_container\_registry\_private\_dns\_zone) | DNS zone name of Azure Container Registry Private endpoints dns name records |
| <a name="output_container_registry_private_endpoint"></a> [container\_registry\_private\_endpoint](#output\_container\_registry\_private\_endpoint) | The ID of the Azure Container Registry Private Endpoint |
| <a name="output_container_registry_private_endpoint_fqdn"></a> [container\_registry\_private\_endpoint\_fqdn](#output\_container\_registry\_private\_endpoint\_fqdn) | Azure Container Registry private endpoint FQDN Addresses |
| <a name="output_container_registry_private_endpoint_ip_addresses"></a> [container\_registry\_private\_endpoint\_ip\_addresses](#output\_container\_registry\_private\_endpoint\_ip\_addresses) | Azure Container Registry private endpoint IPv4 Addresses |
| <a name="output_container_registry_scope_map_id"></a> [container\_registry\_scope\_map\_id](#output\_container\_registry\_scope\_map\_id) | The ID of the Container Registry scope map |
| <a name="output_container_registry_token_id"></a> [container\_registry\_token\_id](#output\_container\_registry\_token\_id) | The ID of the Container Registry token |
| <a name="output_container_registry_webhook_id"></a> [container\_registry\_webhook\_id](#output\_container\_registry\_webhook\_id) | The ID of the Container Registry Webhook |
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | ID of private dns zone. To be used when there is existing dns zone and id is to be passed in private endpoint dns configuration group. |
<!-- END_TF_DOCS -->