# :factory: Project Factory
The project factory is responsible for creating all projects in the organization and setting any initial IAM permissions that are needed on those newly projects.

## :runner: How to run this stage
This stage takes in one variable `projects`, which is a list of dictionaries containing project information.

Set up `main.tf` and `terraform.tfvars`. Be sure to update your bucket name in the `main.tf` file as well as the billing account and parent ID in the `terraform.tfvars` file. 

> **Note:** The parent ID refers to the parent ID in the hierarchy structure. For example, if I want the project to live under the "Production" folder, I would put the ID of said "Production" folder.

```bash
mv main.tf.bootstrap main.tf

mv terraform.tfvars.sample terraform.tfvars
```

Initialize and apply to stand up the initial projects.
```bash
terraform init

terraform apply
```

## :heavy_plus_sign: Creating additional projects
Append any additional projects in the `terraform.tfvars` file in the `projects` variable and run an `apply`.