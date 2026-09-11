output "github_runner_id" {
  value       = aws_instance.github_runner.id
  description = "EC2 Instance ID of the GitHub Runner"
}

output "github_runner_ip" {
  value       = aws_instance.github_runner.public_ip
  description = "Public IP of the GitHub Runner"
}

output "app_server_id" {
  value       = aws_instance.app_server.id
  description = "EC2 Instance ID of the Application Server"
}

output "app_server_ip" {
  value       = aws_instance.app_server.public_ip
  description = "Public IP of the Application Server"
}