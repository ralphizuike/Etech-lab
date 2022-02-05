terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.aws_region
  access_key = "AKIAQDEW47BLLJW27C7Y"
  secret_key = "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"
}

data "aws_availability_zones" "available" {}

# Not required: currently used in conjunction with using
# icanhazip.com to determine local workstation external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See workstation-external-ip.tf for additional information.
provider "http" {}


#kubectl create deployment nginx --image=nginx
#kubectl create service nodeport nginx --tcp=80:80
#
