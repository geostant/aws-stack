# Cloud issue 24941
Cloud stack that uses Anisble to invoke new AMI creation with Packer and Deployment to AWS with Terraform (using Scaling group)

# Requirements
* Ansible 2.5+
* Terraform 0.11+
* Packer 1.3+
* AWS CLI
* ~/.aws/credentials
* AWS MFA (If using 2FA)

# Variables
    Supported variables can be found under `roles/packerMe/vars/main.yml`

#### AWS_REGION
State the desired region to work on
<br><br>
#### AWS_PROFILE
Provide a valid AWS profile new if not using `default` profile
<br><br>
#### AWS_INSTANCE_SIZE
State a valid EC2 instance size (default: `t2.micro`)
<br><br>
#### AVAILABILITY_ZONES [list]  << TODO
Not yet supported, a list of valid AWS AZ based on the working `AWS_REGION`
<br><br>
#### SKIP_PACKER
Use this variable (Boolean) to skip creating a new AMI and jump straight to spinning a new environment (Default: `false`)<br>
**Make sure that your AMI ID is set correctly in terraform**

Overwritting them is simple with flags
`ansible-playbook -e REGION="xyz" -e PROFILE="zyx"...`
<br><br>
# In addition
**TODO:** Dynamic creation using ansible<br> 
Terraform needs a local file called `./terraform/terraform.tfvars` which will hold your
personal variables:
```
AWS_PROFILE = "..."
AWS_REGION = "..."
INSTANCE_SIZE = "..."
AMIS = {
    us-east-1 = "...",
}
```