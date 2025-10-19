variable "instance_type" {
  default = "t2.micro"
}

resource "aws_key_pair" "cloudops_key" {
  key_name   = "cloudops-key"
  public_key = file("~/.ssh/cloudops-key.pub")
}

resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}


resource "aws_instance" "cloudops_app" {
  ami                    = "ami-0c0c758c9da69d9bb" 
  instance_type          = var.instance_type
  key_name               = aws_key_pair.cloudops_key.key_name
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  tags = {
    Name = "cloudops-playground-app"
  }
}

output "public_ip" {
  value = aws_instance.cloudops_app.public_ip
}
