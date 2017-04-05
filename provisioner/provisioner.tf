resource "aws_instance" "web" {

  ami = "ami-4e686b2d"
  instance_type = "t2.micro"
  
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}

