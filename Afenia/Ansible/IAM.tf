resource "aws_iam_role" "AfeniaLambdaRole" {
  name = "AfeniaLambdaRole"

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

  tags = {
    name = "AfeniaLambdaRole"
  }
}

resource "aws_iam_role_policy" "AfeniaLambdaPolicy" {
  name = "AfeniaLambdaPolicy"
  role = aws_iam_role.AfeniaLambdaRole.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "ec2:*",
	  "apigateway:*",
          "cloudwatch:*",
          "logs:*",
          "sns:*",
          "iam:GetPolicy",
          "iam:GetPolicyVersion",
          "iam:GetRole",
	  "s3:*",
          "elasticloadbalancing:*",
          "autoscaling:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": "iam:CreateServiceLinkedRole",
        "Resource": "*",
        "Condition": {
          "StringEquals": {
            "iam:AWSServiceName": [
              "autoscaling.amazonaws.com",
              "ec2scheduled.amazonaws.com",
              "elasticloadbalancing.amazonaws.com",
              "spot.amazonaws.com",
              "spotfleet.amazonaws.com",
              "transitgateway.amazonaws.com"
            ]
          }
        }     
      },
      {
        "Effect": "Allow",
        "Action": "iam:CreateServiceLinkedRole",
        "Resource": "arn:aws:iam::*:role/aws-service-role/events.amazonaws.com/AWSServiceRoleForCloudWatchEvents*",
        "Condition": {
          "StringLike": {
            "iam:AWSServiceName": "events.amazonaws.com"
          }
        }
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "AfeniaPolicyRoleAttachment" {
  role       = aws_iam_role.AfeniaLambdaRole.name
  policy_arn = aws_iam_policy.AfeniaLambdaPolicy.arn
}
