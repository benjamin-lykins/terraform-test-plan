terraform {
  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = "3.3.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

data "dns_a_record_set" "google" {
  host = "google.com"
}

//this resource will always recreate. 
resource "random_id" "rng" {
  keepers = {
    first = "${timestamp()}"
  }     
  byte_length = 8
}

output "google_addrs" {
  value = join(",", data.dns_a_record_set.google.addrs)
}

output "random_id" {
  value = random_id.rng.id
}