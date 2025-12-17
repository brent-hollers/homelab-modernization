provider "aws" {
  region = var.aws_region
}

# --- AWS Target Network
resource "aws_vpc" "migration_target_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Migration-Target-VPC"
  }
}

resource "aws_subnet" "db_subnet" {
  vpc_id            = aws_vpc.migration_target_vpc.id
  cidr_block        = var.vpc_cidr
  availability_zone = var.subnet_az

  tags = {
    Name = "Target-DB-Subnet"
  }
}

# --- VPN Gateway for AWS access
resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = aws_vpc.migration_target_vpc.id

  tags = {
    Name = "AWS-Side-Gateway"
  }
}

# --- Customer access gateway (homelab)
resource "aws_customer_gateway" "home_lab_cgw" {
  bgp_asn    = 65000
  ip_address = var.home_public_ip
  type       = "ipsec.1"

  tags = {
    Name = "Home-Lab-Gateway"
  }
}

# --- VPN connection between homelab and AWS
resource "aws_vpn_connection" "home_to_aws" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gw.id
  customer_gateway_id = aws_customer_gateway.home_lab_cgw.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = {
    Name = "Home-Lab-VPN-Tunnel"
  }
}

# --- Routing between AWS and homelab
resource "aws_vpn_connection_route" "office_network" {
  destination_cidr_block = var.internal_network_cidr
  vpn_connection_id      = aws_vpn_connection.home_to_aws.id
}