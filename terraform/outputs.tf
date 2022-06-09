output "cloudtrail_arn" {
  value = aws_cloudtrail.master_cloudtrail.arn
}

output "cloudtrail_home_region" {
  value = aws_cloudtrail.master_cloudtrail.home_region
}

output "cloudtrail_id" {
  value = aws_cloudtrail.master_cloudtrail.id
}