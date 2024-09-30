# Terraform Project:
### Overview:
Remote State refers to storing the state of your infrastructure in a remote location instead of locally. This allows multiple users or teams to work on the same infrastructure and collaborate effectively, ensuring that the state file is always up-to-date and secure.
<br>
[Main1](./main1.tf) and [Main2](./main2.tf) files resemble 2 remote users connecting and working on the same S3 bucket

## Requirements:
- AWS S3 Bucket
- Terraform

## Configuration:
(For files [Main1](./main1.tf) and [Main2](./main2.tf))
<br>
- Need to add AWS provider information:
  - access_key
  - secret_key
  - region
- Need to configure the S3 bucket information:
  - bucket: Name of the S3 bucket where the state file will be stored.
  - key: Path inside the bucket where the state file will be saved.
  - region: AWS region where the bucket is located.
