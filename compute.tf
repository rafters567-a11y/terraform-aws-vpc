data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  instance_type = lookup(var.instance_types, terraform.workspace, "t3.micro")
}

resource "aws_security_group" "app" {
  name        = "${var.project_name}-${terraform.workspace}-app-sg"
  description = "App instance: no inbound, all outbound"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "${var.project_name}-${terraform.workspace}-app-sg" })
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.al2023.id
  instance_type          = local.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.app.id]

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_size = 8
    encrypted   = true
  }

  tags = merge(local.common_tags, { Name = "${var.project_name}-${terraform.workspace}-app" })
}
