resource "aws_iam_role" "lambda_start_stop" {
  name = "scheduler_start_stop"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "lambdapol_start_stop" {
  name = "start_stop"
  role = aws_iam_role.lambda_start_stop.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            "Action": [
                "ssm:PutParameter",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter",
                "redshift:ResumeCluster",
                "redshift:PauseCluster",
                "redshift:DescribeClusters",
                "rds:StopDBInstance",
                "rds:StopDBCluster",
                "rds:StartDBInstance",
                "rds:StartDBCluster",
                "rds:DescribeDBInstances",
                "rds:DescribeDBClusters",
                "logs:PutLogEvents",
                "logs:CreateLogStream",
                "logs:CreateLogGroup",
                "eks:ListNodegroups",
                "eks:ListClusters",
                "eks:DescribeNodegroup",
                "ecs:UpdateService",
                "ecs:ListServices",
                "ecs:ListClusters",
                "ec2:StopInstances",
                "ec2:StartInstances",
                "ec2:DescribeInstances",
                "cloudwatch:*",
                "autoscaling:UpdateAutoScalingGroup",
                "autoscaling:DescribeAutoScalingGroups"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }        
    ]
  })
}

#resource "aws_iam_role_policy_attachment" "lambda_start_stop" {
#  role       = aws_iam_role.lambda_start_stop.name
#  policy_arn = aws_iam_role_policy.lambdapol_start_stop.arn  
#}