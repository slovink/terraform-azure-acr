<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform Azure Acr
</h1>

<p align="center" style="font-size: 1.2rem;"> 
    Terraform module to create Acr resource on Azure.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.1.7-green" alt="Terraform">
</a>
<a href="LICENSE.md">
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
  source              = "../"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

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



## Feedback
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/slovink/terraform-azure-acr), or feel free to drop us an email at [devops@slovink.com](devops@slovink.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/slovink/terraform-azure-acr)!
