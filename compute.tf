resource "aws_instance" "demo" {
    ami = var.ami
    instance_type = var.instance
    subnet_id = aws_subnet.demo-public-subnet.id
    key_name = aws_key_pair.demo-key.key_name
    security_groups = [ aws_security_group.demo-sg.id ]

    provisioner "remote-exec" {
        inline = [ "sudo apt update" ]
        connection {
          type = "ssh"
          host = self.public_ip
          private_key = file("/Users/ramprasad/.ssh/id_rsa")
          user = "ubuntu"
        }
      
    }



  
}

resource "aws_key_pair" "demo-key" {
    key_name = var.key-name
    public_key = file("/Users/ramprasad/.ssh/id_rsa.pub")
  
}


