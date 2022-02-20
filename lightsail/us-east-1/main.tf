terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.70.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

#WG7

resource "aws_lightsail_static_ip_attachment" "wg7-ip-attach" {
  static_ip_name = aws_lightsail_static_ip.wg7-staticIP.id
  instance_name  = aws_lightsail_instance.hel-wg7-server.id
}

resource "aws_lightsail_static_ip" "wg7-staticIP" {
  name = "wg7-staticIP"
}

resource "aws_lightsail_instance" "hel-wg7-server" {
  name              = "hel-wg7-server"
  availability_zone = "us-east-1a"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = "id_ed25519"
}


# only the to_port matters... the from_port doesn't seem to do anything
resource "aws_lightsail_instance_public_ports" "wg7-ports" {
  instance_name = aws_lightsail_instance.hel-wg7-server.name

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
  }
  port_info {
    protocol  = "tcp"
    from_port = 44158
    to_port   = 44158
  }
  port_info {
    protocol  = "udp"
    from_port = 51936
    to_port   = 51936
  }
}
