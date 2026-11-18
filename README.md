# AWS CloudFront with S3 using Terraform
## Architecture
<img width="822" height="563" alt="cloudfront" src="https://github.com/user-attachments/assets/56e05049-9b8b-495c-bcae-e0724aa7d8dc" />

## Overview

This project uses **Terraform** to provision an AWS infrastructure for hosting a static website using Amazon S3 and Amazon CloudFront.
CloudFront distributes website content through its global edge locations, reducing latency and improving performance for users worldwide.
The S3 bucket remains private, with CloudFront accessing its content securely using Origin Access Control (OAC).

## S3 Backend

## Architecture

- **Amazon S3:** Stores static website files (HTML, CSS, JavaScript).
- **Amazon CloudFront:** Distributes website content globally.
- **Origin Access Control (OAC):** Allows CloudFront to securely access the private S3 bucket.
- **S3 Bucket Policy:** Restricts access to the designated CloudFront distribution.
- **S3 Versioning:** Maintains versions of stored objects.
- **S3 Encryption:** Enables server-side encryption using AES-256.
- **Terraform:** Automates infrastructure provisioning.

## Technologies Used

- AWS (S3, CloudFront, OAC, IAM)
- Terraform
- AWS CLI
- HTML, CSS and JavaScript

## Project Structure

```text
.
├── website/
├── backend.tf
├── cloudfront.tf
├── outputs.tf
├── provider.tf
├── s3.tf
├── variables.tf
└── README.md
```
