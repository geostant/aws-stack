# Cloud issue 24941
Cloud stack that uses Anisble to invoke new AMI creation with Packer and Deployment to AWS with Terraform (using Scaling group)

# Requirements
* Ansible 2.5+
* Terraform 0.11+
* Packer 1.3+
* AWS CLI
* AWS MFA (If using 2FA)

# Variables
Variables can be found under `roles/packerMe/vars/main.yml`
* AWS_REGION
* AWS_PROFILE
* AWS_INSTANCE_SIZE
* AVAILABILITY_ZONES [list]  << TODO

Overwritting them is simple with flags
`ansible-playbook -e REGION="xyz" -e PROFILE="zyx"...`

In addition, terraform needs a local file called `./terraform/terraform.tfvars` which will hold your
personal variables:
```
AWS_PROFILE = "..."
AWS_REGION = "..."
INSTANCE_SIZE = "..."
AMIS = {
    us-east-1 = "...",
}
```