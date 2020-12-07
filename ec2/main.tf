provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "mytest-key" {
  key_name   = "terraform-21days"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8lcUEAoGvqHD9qaMn3M5/p3vWlAibH8oHU48KsQuFavqq7dvUHyEFo3JvSOtUIPaB3vwqvL0fjj6cJNf22xfjQhGHnFAB+THanXN2WFQlMnMwPAuxhLvVG8e2bQA/fSpSAC7oHHbbzCC3HawEDyCTixaLYZIUBwOh4NkrbySbjYot6+dzuhsM6qpXoTWsndnRHhhYOdPqiy2aah3STR+gh+OzjELLW+7sqwrFRYhyCRb3QM62xJ3NKmFL16el7FcOyabGPDUgJY+76jkXx9ffKuKHyBlXYtuxnZs7ew1um+PwlUnR8oEbphgdzgUsTH3hhg8faZxU48JM2sch4XHV davron1989@bastion-fuchicorp-com"
}

resource "aws_security_group" "examplesg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
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
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-01ed306a12b7d1c96"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.examplesg.id}"]
  key_name               = "${aws_key_pair.mytest-key.id}"

  tags = {
    Name = "test-terrafrom"
  }
}
