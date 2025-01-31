# Lab 03: Create Key, Create VM, Install Nginx using Ansible

## Goal
The goal of this lab is to create an SSH key pair, create a virtual machine (VM) on AWS, and install Nginx using Ansible.

## Steps

1. **Initialize Terraform:**
   ```sh
   cd terraform
   terraform init
   ```

2. **Plan Terraform Configuration:**
   ```sh
   terraform plan -var-file="lab_03.tfvars"
   ```

3. **Apply Terraform Configuration:**
   ```sh
   terraform apply -var-file="lab_03.tfvars" -auto-approve
   ```

4. **Extract the Private Key:**
   - Run the provided script to extract the private key:
     ```sh
     cd ..
     bash extract_key.sh
     ```

5. **Install Nginx using Ansible:**
   - Run the Ansible playbook to install Nginx:
     ```sh
     cd playbooks
     ansible-playbook -i hosts.ini install_nginx.yml
     ```

6. **Verify Nginx Home Page:**
   - Open a web browser and navigate to `http://<instance_public_ip>` to verify that the Nginx home page is visible.

Replace `<instance_public_ip>` with the public IP address of the instance.

## Cleanup

To destroy the resources created by this lab, run:
```sh
cd terraform
terraform destroy -var-file="lab_03.tfvars"
```
