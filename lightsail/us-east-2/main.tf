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
  region = "us-east-2"
}

#WG6

resource "aws_lightsail_static_ip_attachment" "wg6-ip-attach" {
  static_ip_name = aws_lightsail_static_ip.wg6-staticIP.id
  instance_name  = aws_lightsail_instance.hel-wg6-server.id
}

resource "aws_lightsail_static_ip" "wg6-staticIP" {
  name = "wg6-staticIP"
}

resource "aws_lightsail_instance" "hel-wg6-server" {
  name              = "hel-wg6-server"
  availability_zone = "us-east-2c"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = "id_ed25519"
}


# only the to_port matters... the from_port doesn't seem to do anything
resource "aws_lightsail_instance_public_ports" "wg6-ports" {
  instance_name = aws_lightsail_instance.hel-wg6-server.name

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




#WG2

resource "aws_lightsail_static_ip_attachment" "wg2-ip-attach" {
  static_ip_name = aws_lightsail_static_ip.wg2-staticIP.id
  instance_name  = aws_lightsail_instance.hel-wg2-server.id
}

resource "aws_lightsail_static_ip" "wg2-staticIP" {
  name = "wg2-staticIP"
}

resource "aws_lightsail_instance" "hel-wg2-server" {
  name              = "hel-wg2-server"
  availability_zone = "us-east-2c"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = "id_ed25519"
}


# only the to_port matters... the from_port doesn't seem to do anything
resource "aws_lightsail_instance_public_ports" "wg2-ports" {
  instance_name = aws_lightsail_instance.hel-wg2-server.name

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

