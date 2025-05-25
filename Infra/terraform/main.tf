provider "aws" {
  region = "us-east-1"
}

# Create a Security Group to allow port 3000
resource "aws_security_group" "devops_sg" {
  name        = "devops_sg"
  description = "Allow traffic on port 3000"

  ingress {
    description = "Allow HTTP on port 3000"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance with user_data to install Node.js and run your app
resource "aws_instance" "devops_ec2" {
  ami           = "ami-084568db4383264d4" # Amazon Linux 2
  instance_type = "t2.micro"
  security_groups = [aws_security_group.devops_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              curl -sL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs git
              git clone https://github.com/konikasingh/Test.git
              cd Test
              npm install
              nohup node src/app.js > app.log 2>&1 &
            EOF

  tags = {
    Name = "DevOps-Practice-Instance"
  }
}
