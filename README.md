# AWS CloudFront with S3 using Terraform
## Architecture
<img width="822" height="563" alt="cloudfront" src="https://github.com/user-attachments/assets/56e05049-9b8b-495c-bcae-e0724aa7d8dc" />

## Overview

This project uses **Terraform** to provision an AWS infrastructure for hosting a static website using Amazon S3 and Amazon CloudFront.
CloudFront distributes website content through its global edge locations, reducing latency and improving performance for users worldwide.
The S3 bucket remains private, with CloudFront accessing its content securely using Origin Access Control (OAC).

## S3 Backend
- Since we are working with AWS, we will leverage S3 to store our terraform state file. This is because storing our terraform state file
  remotely is much more secure than keeping it locally. Human error, accidental deletion are also risks associated with storing it locally.
  In addition, storing it remotely will enable seamless collaboration as any other entity working on the same terraform project can
  access it - with the right controls and access.

- Previously, DynamoDB was utilised alongside S3 to provide state locking, to prevent concurrent operations, which could result in corrupting
  the state file. However, terraform has made this process more convenient by providing state locking through "use_lockfile = true" configuration.
  Therefore, we will only be utilising S3 with the built in configuration, rather than the deprecated DynamoDB method.
  (The configuration for this process is in backend.tf)
## Architecture Componenets

- **Amazon S3:** Stores static website files (HTML, CSS, JavaScript).
- **Amazon CloudFront:** Distributes website content globally.
- **Origin Access Control (OAC):** Allows CloudFront to securely access the private S3 bucket.
- **S3 Bucket Policy:** Restricts access to the designated CloudFront distribution.
- **S3 Versioning:** Maintains versions of stored objects.
- **S3 Encryption:** Enables server-side encryption using AES-256.
- **Terraform:** Automates infrastructure provisioning.

## How It Works

The infrastructure uses Amazon S3 as the origin for static website files and Amazon CloudFront as the Content Delivery Network (CDN).

1. **Website Storage:** Static website files (HTML, CSS, JavaScript) are stored in a private S3 bucket.

2. **CloudFront Distribution:** CloudFront is configured with the S3 bucket as its origin. It distributes content through AWS global edge locations.

3. **Secure Access with OAC:** Origin Access Control (OAC) allows CloudFront to access the private S3 bucket securely. The S3 bucket policy grants access only to the designated CloudFront distribution.

4. **User Request:** When a user visits the CloudFront URL, CloudFront checks whether the requested content is already cached at an edge location.

5. **Content Delivery:** If the content is cached, CloudFront serves it directly from the edge location. Otherwise, it retrieves the content from the S3 bucket, caches it, and delivers it to the user.

6. **Terraform Automation:** Terraform provisions and manages the AWS resources, including the S3 bucket, bucket policy, CloudFront distribution, and related configurations.

### Request Flow

```text
          User / Browser
                |
                | HTTPS Request
                v
        Amazon CloudFront
                |
          Cache Available?
             /     \
           Yes      No
            |        |
            |        v
            |    Private S3 Bucket
            |        ^
            |        |
            |   Origin Access
            |   Control (OAC)
            |        |
            +--------+
                |
                v
          Website Content
                |
                v
          User / Browser
```

### Why This Architecture?

- **Performance:** CloudFront caches content closer to users through global edge locations.
- **Security:** The S3 bucket remains private and is accessible through CloudFront using OAC.
- **Scalability:** CloudFront handles content delivery without requiring you to manage web servers.
- **Cost Efficiency:** Cached content reduces repeated requests to the S3 origin.
- **Infrastructure as Code:** Terraform makes the infrastructure repeatable, version-controlled, and easier to maintain.

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

## Potential Improvements

- Custom Domain : To further enhance this architecture we could register/ use existing domain
  This would closely mimic a real-world example setup of Cloud Front and the processes behind users incurring requests.
  
- Another great way to enhance this setup is by requesting a SSL certificate through Amazon Certificate Manger.
  This will improve the security posture of our website, by restricting traffic to encrypted/secure traffic. (HTTPS)
  By doing so, it will assist in also reducing spam and bot activity- which incur additional costs.
  
- Setting up a CI/CD pipeline via GitHub Actions, will improve efficiency through automation- while ensuring the
  maintenance of our website remains seamless and secure. 
