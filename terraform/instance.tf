resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

resource "aws_launch_configuration" "packerMe-ALC" {
  name_prefix            = "packerMe-"
  image_id               = "${lookup(var.AMIS, var.AWS_REGION)}"
  key_name               = "${aws_key_pair.mykey.key_name}"
  instance_type          = "${var.AWS_INSTANCE_SIZE}"
  security_groups        = ["${aws_security_group.allow-ssh.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "packerMe-ASG" {
  name                 = "packerMe-asg"
  launch_configuration = "${aws_launch_configuration.packerMe-ALC.name}"
  vpc_zone_identifier       = ["${aws_subnet.packerVPC-public-1.id}"]
  min_size                  = 1
  max_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "packerMe-CPU" {
  name                   = "packerMe-CPU"
  autoscaling_group_name = "${aws_autoscaling_group.packerMe-ASG.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}
