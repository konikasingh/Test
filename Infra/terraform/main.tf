provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "devops_ec2" {
  ami           = "ami-084568db4383264d4" # Amazon Linux 2 (example)
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
            EOF

  tags = {
    Name = "DevOps-Practice-Instance"
  }
}
