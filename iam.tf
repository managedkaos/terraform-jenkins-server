resource "aws_iam_role" "iam" {
  name_prefix = "${var.name}-${var.environment}-"
  tags        = local.tags
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_instance_profile" "iam" {
  name_prefix = "${var.name}-"
  role        = aws_iam_role.iam.name
}

resource "aws_iam_policy" "iam" {
  name_prefix = "${var.name}-${var.environment}-"
  tags        = local.tags
  path        = "/"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParametersByPath",
          "ssm:GetParameters"
        ],
        "Resource" : [
          "arn:aws:ssm:${data.aws_region.default.name}:${data.aws_caller_identity.id.account_id}:parameter/${var.name}/${var.environment}/*",
          "arn:aws:ssm:${data.aws_region.default.name}:${data.aws_caller_identity.id.account_id}:parameter/${var.name}/${var.environment}"
        ]
      }    
    ]
  })
}

resource "aws_iam_role_policy_attachment" "iam" {
  role       = aws_iam_role.iam.name
  policy_arn = aws_iam_policy.iam.arn
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.iam.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
