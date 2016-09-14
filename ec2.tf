resource "aws_security_group" "bar" {
  name = "bar"
  description = "security group for bar"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bar1" {
  ami = "${var.ami}"
  availability_zone = "us-east-1a"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.bar.name}"]
}

resource "aws_instance" "bar2" {
  ami = "${var.ami}"
  availability_zone = "us-east-1b"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.bar.name}"]
}

resource "aws_elb" "bar" {
  name = "bar"
  availability_zones = ["us-east-1a","us-east-1b"],

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:80/"
    interval = 30
  }
  instances = ["${aws_instance.bar2.id}","${aws_instance.bar1.id}"]
}
