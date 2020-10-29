variable "INSTANCES" {
  description = "Map of each instance and their configuration settings"
  type        = map
  default = {
    appserver = {
      tags       = "app"
      network_ip = "10.138.0.44"
    }

    webserver = {
      tags       = "web"
      network_ip = "10.138.0.45"
    }

    dbserver = {
      tags       = "sql"
      network_ip = "10.138.0.46"
    }
  }
}

variable "PUBLIC_KEY" {
  description = "Path to the public SSH key you want to bake into the instance."
  default     = "/home/stu/code/arctiq-mission/keys/mykey.pub"
}

variable "PRIVATE_KEY" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "/home/stu/code/arctiq-mission/keys/mykey"
}

variable "SSH_USER" {
  description = "SSH user name to connect to your instance."
  default     = "ubuntu"
}

variable "PROJECT" {
  description = "Which project to deploy instances to."
  default = "phrasal-planet-293419"
}

variable "REGION" {
      default = "us-west1"
}

variable "ZONE" {
  default = "us-west1-a"
}

variable "MACHINE_TYPE" {
  default = "e2-standard-4"
}

variable "IMAGE" {
  description = "Which image to deploy on instances."
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
}