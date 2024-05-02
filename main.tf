resource "aws_s3_bucket" "portfolio" {
  bucket        = var.bucket_name 
  force_destroy = true
}
resource "aws_s3_bucket_website_configuration" "dgportfolio" {
  bucket = aws_s3_bucket.portfolio.id 

  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_bucket_ownership_controls" "my-static-website" {
  bucket = aws_s3_bucket.portfolio.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "my-static-website" {
  bucket = aws_s3_bucket.portfolio.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_acl" "my-static-website" {
  bucket = aws_s3_bucket.portfolio.id
  acl    = "public-read"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.portfolio.id
  key    = "index.html"
  source = "index.html"
  content_type = "text/html"
  acl = "public-read"
}




