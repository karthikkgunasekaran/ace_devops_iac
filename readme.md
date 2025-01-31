# Setup Instructions

## Prerequisites

1. Ensure Terraform >= 1.10.5 is installed. You can download it from the [Terraform website](https://www.terraform.io/downloads.html).

2. Install the required Python packages:
    ```sh
    pip install -r requirements.txt
    ```

## Environment Setup

1. Create a `.env` file from the `.env.example` file with appropriate values:
    ```sh
    cp .env.example .env
    ```

2. Edit the `.env` file and replace `your_access_key_id` and `your_secret_access_key` with your actual AWS credentials.

3. Export the environment variables:
    ```sh
    set -a && source .env && set +a
    ```

## Lab 04 and 05

### Pre-Requisites: Jenkins Setup

1. Execute the Jenkins setup script:
    ```sh
    ./0_setup_jenkins.sh
    ```