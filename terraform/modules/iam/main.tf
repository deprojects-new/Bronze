provider "aws" {
  region = "us-east-2"
}

##############################
# IAM Groups + Policy Attach #
##############################

# --- Group: ProjectTeam ---
resource "aws_iam_group" "project_team" {
  name = "ProjectTeam"
}

# Least Privilege Policy for All Team Members
resource "aws_iam_policy" "project_team_least_privilege" {
  name = "ProjectTeamLeastPrivilegePolicy"
  description = "Least privilege policy for all team members - access to all project components"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:CreateBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:DeleteBucket",
          "s3:PutBucketVersioning",
          "s3:PutBucketLifecycleConfiguration",
          "s3:GetBucketVersioning",
          "s3:GetLifecycleConfiguration"
        ]
        Resource = [
          "arn:aws:s3:::bronze-*",
          "arn:aws:s3:::bronze-*/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "glue:CreateJob",
          "glue:StartJobRun",
          "glue:StopJobRun",
          "glue:GetJob",
          "glue:GetJobRun",
          "glue:ListJobs",
          "glue:ListJobRuns",
          "glue:UpdateJob",
          "glue:DeleteJob",
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:GetTable",
          "glue:GetTables",
          "glue:CreateDatabase",
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:BatchCreatePartition",
          "glue:BatchDeletePartition",
          "glue:GetPartition",
          "glue:GetPartitions",
          "glue:UpdatePartition"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "lambda:CreateFunction",
          "lambda:UpdateFunction",
          "lambda:DeleteFunction",
          "lambda:InvokeFunction",
          "lambda:GetFunction",
          "lambda:ListFunctions",
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:GetFunctionConfiguration",
          "lambda:AddPermission",
          "lambda:RemovePermission",
          "lambda:GetPolicy",
          "lambda:PutFunctionConcurrency",
          "lambda:DeleteFunctionConcurrency"
        ]
        Resource = "arn:aws:lambda:us-east-1:*:function:bronze-*"
      },
      {
        Effect = "Allow"
        Action = [
          "lambda:ListFunctions",
          "lambda:ListEventSourceMappings"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "states:CreateStateMachine",
          "states:UpdateStateMachine",
          "states:DeleteStateMachine",
          "states:StartExecution",
          "states:StopExecution",
          "states:DescribeStateMachine",
          "states:ListStateMachines",
          "states:ListExecutions",
          "states:GetExecutionHistory",
          "states:DescribeExecution"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:PutMetricData",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:PutMetricAlarm",
          "cloudwatch:DeleteAlarms",
          "cloudwatch:DescribeAlarmHistory",
          "cloudwatch:GetMetricWidgetImage"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:GetLogEvents",
          "logs:FilterLogEvents",
          "logs:DeleteLogGroup",
          "logs:DeleteLogStream"
        ]
        Resource = [
          "arn:aws:logs:us-east-1:*:log-group:/aws/glue/*",
          "arn:aws:logs:us-east-1:*:log-group:/aws/lambda/bronze-*",
          "arn:aws:logs:us-east-1:*:log-group:/aws/states/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:PassRole",
          "iam:CreateRole",
          "iam:DeleteRole",
          "iam:AttachRolePolicy",
          "iam:DetachRolePolicy",
          "iam:PutRolePolicy",
          "iam:DeleteRolePolicy",
          "iam:GetRolePolicy",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:TagRole",
          "iam:UntagRole"
        ]
        Resource = [
          "arn:aws:iam::*:role/bronze-*",
          "arn:aws:iam::*:role/AWSGlueServiceRole*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:ListRoles",
          "iam:ListPolicies",
          "iam:GetPolicy",
          "iam:GetPolicyVersion"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeInstances",
          "ec2:DescribeRegions",
          "ec2:DescribeAvailabilityZones"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey",
          "kms:DescribeKey",
          "kms:CreateGrant",
          "kms:ListGrants"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "events:PutEvents",
          "events:PutRule",
          "events:PutTargets",
          "events:DeleteRule",
          "events:DeleteTargets",
          "events:DescribeRule",
          "events:ListRules",
          "events:ListTargetsByRule"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach least privilege policy to project team group
resource "aws_iam_group_policy_attachment" "project_team_least_privilege" {
  group      = aws_iam_group.project_team.name
  policy_arn = aws_iam_policy.project_team_least_privilege.arn
}

##############################
# IAM Users + Group Mapping  #
##############################

# User: Abhinav → ProjectTeam
resource "aws_iam_user" "abhinav" {
  name = "Abhinav"
  path = "/users/"
  tags = {
    Project = "Bronze"
    Role    = "TeamMember"
  }
}

resource "aws_iam_user_login_profile" "abhinav_login" {
  user                    = aws_iam_user.abhinav.name
  password_length         = 16
  password_reset_required = true
}

resource "aws_iam_user_group_membership" "abhinav_project_team" {
  user   = aws_iam_user.abhinav.name
  groups = [aws_iam_group.project_team.name]
}

# User: Priya → ProjectTeam
resource "aws_iam_user" "priya" {
  name = "Priya"
  path = "/users/"
  tags = {
    Project = "Bronze"
    Role    = "TeamMember"
  }
}

resource "aws_iam_user_login_profile" "priya_login" {
  user                    = aws_iam_user.priya.name
  password_length         = 16
  password_reset_required = true
}

resource "aws_iam_user_group_membership" "priya_project_team" {
  user   = aws_iam_user.priya.name
  groups = [aws_iam_group.project_team.name]
}

# User: Srinidhi → ProjectTeam
resource "aws_iam_user" "srinidhi" {
  name = "Srinidhi"
  path = "/users/"
  tags = {
    Project = "Bronze"
    Role    = "TeamMember"
  }
}

resource "aws_iam_user_login_profile" "srinidhi_login" {
  user                    = aws_iam_user.srinidhi.name
  password_length         = 16
  password_reset_required = true
}

resource "aws_iam_user_group_membership" "srinidhi_project_team" {
  user   = aws_iam_user.srinidhi.name
  groups = [aws_iam_group.project_team.name]
}
