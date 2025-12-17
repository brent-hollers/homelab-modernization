output "vpn_connection_id" {
  description = "The ID of the VPN connection"
  value       = aws_vpn_connection.home_to_aws.id
}

output "vpc_id" {
  description = "The ID of the Migration VPC"
  value       = aws_vpc.migration_target_vpc.id
}

output "vpn_configuration_instructions" {
  description = "Command to retrieve the Pre-Shared Keys and Tunnel IPs"
  value       = "Run this command: aws ec2 describe-vpn-connections --vpn-connection-ids ${aws_vpn_connection.home_to_aws.id} --output json"
}