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
Variables are being set and read form `variables.json` in the root diretory of this project, in order to make the variables accessaible to all the tools involved

    AWS_REGION
    ----------
    State the desired region to work on
    
    AWS_PROFILE
    -----------
    Provide a valid AWS profile new if not using `default` profile
    
    AWS_INSTANCE_SIZE
    -----------------
    State a valid EC2 instance size (default: `t2.micro`)
    
    AWS_AVAILABILITY_ZONES
    ------------------------  
    A dynamic list of AWS AZ based on `AWS_REGION`
    
    SSH_USER
    --------
    Default SSH username to be used to access the deployed machines [at the moment ALWAYS `ubuntu`]
    
    AWS_OWNER_ID
    ------------
    To be able to perform CRUD operations, the ID is needed
    
    AMI_NAME
    --------
    Prefix to packer created AMI [template: `AMI_NAME-dev-{timestamp}`]

    AMI_ID
    ------
    Automatically populated variable once packer finish his build

    variables_delete [boolean]
    ----------------
    If true, will delete variables.json and will re-create it with provided variables [default: yes]
    
    TODO: SKIP_PACKER [boolean]
    -----------------
    Use this variable to skip creating a new AMI and jump straight to spinning a new environment (Default: `false`)

Overwritting them is simple with flags (make sure that you input `yes` or provide flag for variables.json delete): `ansible-playbook -e AWS_REGION="xyz" -e AWS_PROFILE="zyx"...`
<br><br>
Packer needs a local file called `{PROJECT_ROOT}/variables.json` which will hold your environment **GLOBAL** variables (shared between ansible, packer add terraform)

If the file is absent, ansible will create one for you:
```
{
    "AWS_PROFILE": "...",
    "AWS_REGION": "...",
    "AWS_AVAILABILITY_ZONES": "...,...,...",
    "AWS_INSTANCE_SIZE": "...",
    "SSH_USER": "ubuntu",
    "AWS_OWNER_ID": "...",
    "AMI_NAME": "...",
    "AMI_ID": "ami-..."
}

```