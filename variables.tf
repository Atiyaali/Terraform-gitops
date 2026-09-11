variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "environment" {
  type = string
  default = "dev"     
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "github_repo_url" {
  type        = string
  description = "The full URL of your GitHub repository (e.g., https://github.com/my-username/my-repo)"
}

variable "github_token" {
  type        = string
  description = "The temporary self-hosted runner registration token from GitHub"
  sensitive   = true
}       