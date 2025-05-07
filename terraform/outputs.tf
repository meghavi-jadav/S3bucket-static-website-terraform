output "website_url" {
  value = "http://${var.bucket_name}.s3-website-${var.aws_region}.amazonaws.com}"
}
