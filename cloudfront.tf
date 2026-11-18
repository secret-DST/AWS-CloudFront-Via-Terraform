## OAC allows CloudFron to authenticate its requests to S3
/*signing_behavior = "always" means CloudFront signs its requests to S3.
AWS recommends OAC over the older Origin Access Identity (OAI) approach*/
resource "aws_cloudfront_origin_access_control" "website" {
  name                              = "${var.project_name}-oac"
  description                       = "Access control for private S3 website bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "website" {
  enabled             = true
  comment             = "${var.project_name} distribution"
  default_root_object = "index.html"
  price_class         = "PriceClass_100"
  is_ipv6_enabled     = true

  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = "s3-website-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-website-origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name = "${var.project_name}-cloudfront"
  }
}

/* 
enabled = true - Enables the distribution.
default_root_object  - Serves index.html when someone visits the root URL.
price_class  - Limits the CloudFront edge locations used, helping manage costs.
is_ipv6_enabled	- Supports IPv6 visitors.
origin	- Tells CloudFront where the website files are stored.
origin_access_control_id - Connects CloudFront to your OAC.
redirect-to-https - Redirects HTTP visitors to HTTPS.
allowed_methods	- Allows visitors to retrieve website content using GET and HEAD.
compress - Enables automatic compression of supported content.
cache_policy_id	- Uses AWS's managed CachingOptimized policy. 

(The cache policy ID above is AWS's managed CachingOptimized policy,
It is not something you need to create yourself.)

why use "bucket_regional_domain_name" :
- We use the normal S3 bucket endpoint, not the S3 static website endpoint.
- That's important because OAC works with normal S3 origins, not S3 website endpoints.
*/