# Terraform

This is the instructions for the deployment of all the terraform infrastructure.

## Requirements

Modify the `config/values.tfvars` file with the details to create the new environment.


## Create environment

Locate yourself under the root directory. Initialize the project running the following command:

```
terraform init -backend-config=config/backend.tf
```

Then, create a new terraform workspace o select an existing one. The workspace name is going to be used for the cluster name.

```
terraform workspace <workspace_name>
```

Apply the changes running

```
terraform apply -var-file=../config/values.tfvars
```
