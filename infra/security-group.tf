resource "aws_security_group" "general_access" {
  name        = var.security_group_name
  description = var.security_group_description
  ingress {
    description      = "Receive from all internet"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }
  egress {
    description      = "Send to all internet"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }
  tags = {
    Name = "general_access"
  }
}
