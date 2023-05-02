terraform {
  required_providers {
    rafay = {
      source  = "RafaySystems/rafay"
    }
  }
}

variable "rafay_config_file" {
  description = "rafay provider config file for authentication"
  default     = "/Users/abh1thakur/Downloads/abhishek-rafay-abhishek@rafay.co.json" # Download CLI config, from Rafay console under "My Tools"
  sensitive   = true
}

provider "rafay" {
  provider_config_file = var.rafay_config_file
}