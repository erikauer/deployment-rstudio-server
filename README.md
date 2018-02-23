# Deployment Rstudio Server

Deployment of RStudio Server

## Prerequisites

* Terraform version Terraform v0.11.3 installed
* Configured cloudstack terraform provider

## Run example

     terraform init
     terraform plan -var-file='./exoscale.tfvars' -out=next-steps.plan
     terraform apply next-steps.plan

## Cloudstack Provider Configuration

To configure the cloudstack provider just create a file exoscale.tfvars inside the
root directory of this example, which contains information about the API. Eg.

      cloudstack_api_url = "https://api.exoscale.ch/compute"
      cloudstack_api_key = "EXO02a0186f1234ab2a606700a9"
      cloudstack_secret_key = "6uRPl00k9EddcljHJlywFJEFFOUzJnV9GXICXyicgvY"

## Contribute

Before contribution run

      terraform fmt
      terraform validate -var-file='./exoscale.tfvars'

to run

## Clean up

terraform destroy -var-file='./exoscale.tfvars'
