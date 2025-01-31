# Lab 01: Create Key, Create VM, Extract the Key

## Goal
The goal of this lab is to create an SSH key pair, create a virtual machine (VM) on AWS, and extract the key. No Ansible is involved in this lab.

## Steps

1. **Initialize Terraform:**
   ```sh
   cd terraform
   terraform init
   ```

2. **Plan Terraform Configuration:**
   ```sh
   terraform plan -var-file="lab_01.tfvars"
   ```

3. **Apply Terraform Configuration:**
   ```sh
   terraform apply -var-file="lab_01.tfvars" -auto-approve
   ```

4. **Retrieve the Key and IP Address:**
   - After applying the configuration, note the `instance_public_ip` and `private_key` from the output.

5. **Extract the Private Key:**
   - Run the provided script to extract the private key:
     ```sh
     cd ..
     bash extract_key.sh
     ```

6. **Verify SSH Access:**
   - Use the following command to verify SSH access:
     ```sh
     ssh -i lab01_server_key.pem ec2-user@instance_public_ip echo "SSH connection successful"
     ```

Replace `instance_public_ip` with the public IP address of the instance.

## Cleanup

To destroy the resources created by this lab, run:
```sh
cd terraform
terraform destroy -var-file="lab_01.tfvars"
```
