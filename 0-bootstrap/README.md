# :hammer: Organization bootstrap
The purpose of this stage is to bootstrap the organization, specifically:
- Set any required organization policies
- Lay out the folder structure
- Create an initial project with a shared VPC (including initial subnet, firewall rules, and router)
- Create an initial storage bucket for logging and Terraform state files

## :runner: How to run this stage
Ensure you are authenticated with your application credentials via the [gcloud CLI tool](https://cloud.google.com/sdk/docs/install):
```bash
gcloud auth login 
```

Set up Application Default Credentials (used by [Cloud Client Libraries and Google API Client Libraries](https://cloud.google.com/apis/docs/client-libraries-explained)).
```bash
gcloud auth application-default login
```

Set up `main.tf` and `terraform.tfvars`. Be sure to update your `billing_account_id` and `domain` as well as add any folders that should be created.
```bash
mv main.tf.bootstrap main.tf

mv terraform.tfvars.sample terraform.tfvars
```

Initialize and apply to stand up the initial infrastructure.
```bash
terraform init

terraform apply
```

> output 
```bash
...
Outputs:

bucket_name = "bkt-core-92596"
```

Make note of the Bucket name returned as you will use this to store your Terraform state moving forward. 

Add the following snippet to your `main.tf`:
```bash
  backend "gcs" {
    bucket = "bkt-core-92596"
    prefix = "terraform/bootstrap/state"
  }
```

Re-run an initialization to transfer state to the Bucket (You will be prompted to confirm a copy, enter `yes`):
```bash
terraform init
```

Once completed, your Terraform state is now stored in the bucket.