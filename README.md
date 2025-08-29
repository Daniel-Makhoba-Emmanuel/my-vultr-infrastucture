# Vultr Infrastructure with OpenTofu

This repository contains OpenTofu code to provision and manage infrastructure on Vultr. The project is structured using modules to ensure a clear separation of concerns and promote reusability.

## Project Overview

The primary goal of this repository is to demonstrate the use of OpenTofu for creating a robust and scalable cloud infrastructure on Vultr. It provisions a Vultr Kubernetes Engine (VKE) cluster and a separate Vultr instance, both configured to work together.

### Key Features

  * **Modular Design**: The project is split into reusable modules for the Vultr Kubernetes cluster and the Vultr instance.
  * **Scalable**: Easily customize resource counts and sizes by modifying variables.
  * **Security Best Practices**: The repository's `.gitignore` file is configured to prevent sensitive data from being committed.

## Prerequisites

Before using this code, you must have the following:

  * **OpenTofu CLI**: [Download and install OpenTofu](https://opentofu.org/docs/intro/install/)
  * **Vultr Account**: A valid Vultr account with an active Vultr API Key.

## File Structure

The repository is organized into the following key directories:

  * `main.tf`: The root-level file that orchestrates the entire infrastructure. It calls the necessary modules and configures the provider.
  * `modules/`: Contains the reusable OpenTofu modules for specific Vultr resources.
      * `vultr_instance/`: Module for provisioning a Vultr cloud compute instance.
      * `vultr_k8s_cluster/`: Module for provisioning a Vultr Kubernetes cluster.
  * `variables.tf`: Defines all the input variables for the root module.
  * `outputs.tf`: Defines the outputs that provide key information about the created resources (e.g., IP addresses, cluster details).

## Usage

Follow these steps to deploy the infrastructure:

1.  **Clone the Repository**

    ```bash
    git clone https://github.com/Daniel-Makhoba-Emmanuel/Customizing-Kubernetes-Deployments-with-Kustomize.git
    cd Customizing-Kubernetes-Deployments-with-Kustomize
    ```

2.  **Configure Your Vultr API Key**
    Create a file named `terraform.tfvars` in the root directory. This file is ignored by Git to prevent your sensitive information from being committed.

    Add your Vultr API key to the file.

    ```
    vultr_api_key = "YOUR_VULTR_API_KEY"
    ```

3.  **Initialize OpenTofu**
    Run the `tofu init` command to download the necessary provider plugins.

    ```bash
    tofu init
    ```

4.  **Review the Plan**
    Generate an execution plan and review the changes that OpenTofu will make to your infrastructure.

    ```bash
    tofu plan
    ```

5.  **Apply the Changes**
    Apply the plan to provision the resources on Vultr.

    ```bash
    tofu apply
    ```

## Outputs

After a successful `tofu apply`, OpenTofu will display the output values defined in `outputs.tf`. You can also retrieve them at any time by running:

```bash
tofu output
```

## Security

**⚠️ Important:** Never commit your `terraform.tfvars` file or the `terraform.tfstate` files to Git. The `.gitignore` file is configured to handle this automatically, but it's crucial to ensure these files are never pushed to a public repository. The state file contains sensitive information and the current state of your infrastructure.