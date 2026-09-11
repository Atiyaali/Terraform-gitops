# --- Trust Policy allowing EC2 to assume roles ---
data "aws_iam_policy_document" "ec2_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_runner" {
  name               = "${var.environment}-github-runner-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
  tags               = local.common_tags
}

resource "aws_iam_role_policy_attachment" "runner_ssm" {
  role       = aws_iam_role.github_runner.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "runner_ecr" {
  role       = aws_iam_role.github_runner.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_instance_profile" "github_runner" {
  name = "${var.environment}-github-runner-profile"
  role = aws_iam_role.github_runner.name
}


resource "aws_iam_role" "app_server" {
  name               = "${var.environment}-app-server-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
  tags               = local.common_tags
}

resource "aws_iam_role_policy_attachment" "app_ssm" {
  role       = aws_iam_role.app_server.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "app_ecr" {
  role       = aws_iam_role.app_server.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "app_ec2" {
  role       = aws_iam_role.app_server.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_instance_profile" "app_server" {
  name = "${var.environment}-app-server-profile"
  role = aws_iam_role.app_server.name
}