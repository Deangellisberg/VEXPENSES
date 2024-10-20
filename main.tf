resource "aws_instance" "debian_ec2" {
  ami             = data.aws_ami.debian12.id
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.main_subnet.id
  key_name        = aws_key_pair.ec2_key_pair.key_name
  security_groups = [aws_security_group.main_sg.name]

  associate_public_ip_address = true

  root_block_device {
    volume_size           = 20
    volume_type           = "gp2"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name           = "/dev/xvdf"
    volume_size           = 5
    volume_type           = "gp2"
    delete_on_termination = true
  }

  # Script para configurar logs no volume separado
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get upgrade -y
              apt-get install -y nginx
              mkfs -t ext4 /dev/xvdf
              mkdir -p /mnt/nginx_logs
              mount /dev/xvdf /mnt/nginx_logs
              chown -R www-data:www-data /mnt/nginx_logs
              sed -i 's|access_log /var/log/nginx/access.log|access_log /mnt/nginx_logs/access.log|' /etc/nginx/nginx.conf
              sed -i 's|error_log /var/log/nginx/error.log|error_log /mnt/nginx_logs/error.log|' /etc/nginx/nginx.conf
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "${var.projeto}-${var.candidato}-ec2"
  }
}
