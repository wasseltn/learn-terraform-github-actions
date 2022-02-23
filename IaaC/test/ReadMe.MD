# ReadMe Test 

## Testing using Terratest

Before deploying an infrastracture, we have to test the Terraform script
Terratest performs unit testing, by these operations:

1) Run `terraform init` & `terraform apply` (Fail the test if any error)
2) Run `terraform output` to get the values of output variables and check they have the expected values (Fail the test if not)
3) Cleanup resources with `terraform destroy` 

<hr>

## Tests done :
### Terraform backend :
- Resource group existence
- Storage account existence
- Storage container existence


### Azure Infrastracture :
- Resource group existence
- Storage account existence
- Storage account tier
- Storage container existence
