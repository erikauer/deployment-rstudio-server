terraform fmt
terraform validate -var-file='./exoscale.tfvars'
terraform plan -var-file='./exoscale.tfvars' -out=next-steps.plan
terraform apply next-steps.plan
sleep 5
sh ./scripts/run-ansible.sh
