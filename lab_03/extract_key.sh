#!/bin/bash

# Extract the private key and write it to a file
jq -r '.outputs.private_key.value' terraform/terraform.tfstate > nginx_server_key.pem

# Set the file permissions to 600
chmod 600 nginx_server_key.pem