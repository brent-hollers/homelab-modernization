# AWS Hybrid Cloud Migration Lab

This repository contains the Infrastructure as Code (IaC) using Terraform to establish a hybrid cloud environment. It simulates a corporate migration scenario by connecting an on-premise data center (Dell PowerEdge running ESXi) to Amazon Web Services (AWS) via a Site-to-Site VPN.

## 🏗 Architecture Overview

**On-Premise (Source):**
* **Hardware:** Dell PowerEdge R420
* **Hypervisor:** VMware ESXi 6.x
* **Gateway:** pfSense VM (handling IPsec VPN)
* **Workloads:** Linux Monolith (Apache/MySQL), Legacy SQL Server

**AWS Cloud (Destination):**
* **Network:** Custom VPC (`10.0.0.0/16`)
* **Connectivity:** Virtual Private Gateway (VGW) & Customer Gateway (CGW)
* **Database:** Amazon RDS for PostgreSQL (Migration Target)
* **Compute:** EC2 Landing Zone for migrated apps

## 🚀 Prerequisites

Before running this Terraform code, ensure you have:
1.  [Terraform installed](https://developer.hashicorp.com/terraform/downloads) (v1.0+)
2.  [AWS CLI installed](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and configured with `aws configure`
3.  Your Home Public IP Address (for the Customer Gateway)

## 📂 Repository Structure

```text
.
├── main.tf        # Core infrastructure (VPC, VPN, RDS)
├── outputs.tf     # Returns connection details (VPN IP, RDS Endpoint)
├── variables.tf   # Variable definitions
├── .gitignore     # Ensures secrets (.tfstate) are not committed
└── README.md      # This file