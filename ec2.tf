# Fetch latest Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] 
}

# --- GitHub Runner Instance ---
resource "aws_instance" "github_runner" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.github_runner.name
   user_data = templatefile("${path.module}/scripts/script-runner.tpl", {
    github_repo_url = var.github_repo_url
    github_token    = var.github_token
 }) 
   tags = merge(local.common_tags, {
    Name = "${var.environment}-github-runner"
  })
}

# --- Application Server Instance ---
resource "aws_instance" "app_server" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.app_server.name
  user_data = templatefile("${path.module}/scripts/script-app.tpl", {})
  tags = merge(local.common_tags, {
    Name = "${var.environment}-app-server"
  })
}