provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

import {
  to = aws_vpc.vpc_one
  id = var.vpc_id
}


resource "aws_vpc" "vpc_one" {
  tags = {
    Name = "vpc_one"
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-07dda8ba45946f111"
  instance_type = "t2.micro"
  key_name = ""

  tags = {
    Name = local.instance_name
  }

  user_data = <<-EOF
  #!/bin/bash
    # Update package lists
    sudo yum update -y

    # Install httpd
    sudo yum install -y httpd

    # Start httpd service
    sudo systemctl start httpd

    # Enable httpd to start on boot
    sudo systemctl enable httpd

    # Print the status of httpd service  
    sudo systemctl status httpd
  EOF
}

locals{
  instance_name= "${terraform.workspace}-instance"
}