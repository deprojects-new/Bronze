output "project_team_group_name" {
  description = "Name of the Project Team group"
  value       = aws_iam_group.project_team.name
}

output "abhinav_user_name" {
  description = "Name of the Abhinav user (Team Member)"
  value       = aws_iam_user.abhinav.name
}

output "priya_user_name" {
  description = "Name of the Priya user (Team Member)"
  value       = aws_iam_user.priya.name
}

output "srinidhi_user_name" {
  description = "Name of the Srinidhi user (Team Member)"
  value       = aws_iam_user.srinidhi.name
}

output "project_team_policy_arn" {
  description = "ARN of the Project Team least privilege policy"
  value       = aws_iam_policy.project_team_least_privilege.arn
}

output "all_team_members" {
  description = "List of all team members"
  value = [
    aws_iam_user.abhinav.name,
    aws_iam_user.priya.name,
    aws_iam_user.srinidhi.name
  ]
}

output "team_permissions" {
  description = "Summary of team permissions"
  value = {
    "S3" = "Full access to bronze-* buckets"
    "Glue" = "Full ETL job management and data catalog access"
    "Lambda" = "Full function management for bronze-* functions"
    "Step Functions" = "Full workflow management"
    "CloudWatch" = "Full monitoring and alerting"
    "Logs" = "Full log management for project resources"
    "IAM" = "Role management for project resources"
    "KMS" = "Encryption key access"
    "Events" = "Event management"
  }
}
