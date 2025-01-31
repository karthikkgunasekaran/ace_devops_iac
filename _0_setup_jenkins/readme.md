# Setup Instructions for Lab 04 and 05

## Pre-requisites - Jenkins

### Goal

The goal of this step is to create Jenkins that will be used to create CI/CD pipeline for labs 04 and 05.

### Steps

Run the following script to create the Jenkins Server.
```sh
cd _0_setup_jenkins/terraform
terraform init
terraform plan -var-file="jenkins.tfvars"
terraform apply -var-file="jenkins.tfvars" -auto-approve
```
Extract the following script to extract the private key from terraform output file and save it as .pem
```sh
cd ..
bash extract_key.sh
```
### Running Ansible Playbook
After the Terraform script has completed, run the Ansible playbook to install and configure Jenkins:
```sh
cd playbooks
ansible-playbook -i hosts.ini install_jenkins.yml
```

### Complete Jenkins Setup

1. Note the initial admin password for Jenkins printed in the terminal.
2. Login to the Jenkins portal using the assigned public IP: `http://{public_ip}`, username: `admin`, and the password from the previous step.
3. Install the recommended plugins.
4. Skip creating the first admin user and continue as admin.
5. Skip the instance configuration by clicking 'Not Now'. If not configured, this may impact performance during system restart.
6. Click 'Start using Jenkins' on the next screen.
7. Click 'Build Executor Status' and ensure the 'Built-In Node' has sufficient free disk space and free temp space. A warning on free swap space is not an issue at this point. Note that t2-medium instances do not have sufficient free temp space for Jenkins to work; the minimum configuration should be t2-large.

### Clean Up Resources

After completing the labs, you can destroy the created resources to avoid incurring costs. Run the following command:
```sh
cd _0_setup_jenkins/terraform
terraform destroy -var-file="jenkins.tfvars"
```