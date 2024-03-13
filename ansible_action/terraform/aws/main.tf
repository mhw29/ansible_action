provider "aws" {
  region = "us-east-1"  # Change to your desired AWS region
}

# Create a security group
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Security group for web server"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]  # Replace "your_ip" with your public IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EBS volume
resource "aws_ebs_volume" "this" {
  availability_zone = aws_instance.this.availability_zone
  size              = 30
}

# Attach the volume to the instance
resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = aws_instance.this.id
}

# Create a key pair for SSH access
resource "aws_key_pair" "this" {
  key_name   = "my_key_pair"
  public_key = file("~/.ssh/id_ed25519.pub") 
}

# Create the EC2 instance
resource "aws_instance" "this" {
  ami                    = "ami-0f403e3180720dd7e" 
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.this.key_name
  security_groups        = [aws_security_group.web_sg.name]
  associate_public_ip_address = true

  tags = {
    Name = "ansible_action"
  }
  
}
