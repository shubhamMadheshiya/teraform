resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub") # Ensure this file exists and contains a valid SSH public key
}

resource "aws_instance" "dove-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = ["sg-0e274dcc86cc48f0a"] # Make sure this security group allows SSH (port 22)

  tags = {
    Name    = "Dove-Instance"
    Project = "Dove"
  }

  # Upload the web.sh script to the instance
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  # Run the uploaded script using remote-exec
  provisioner "remote-exec" {

    inline = [
      "chmod /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  # Connection details for remote-exec and file provisioners
  connection {
    user        = var.USER        # Ensure var.USER matches the AMI default user (e.g., 'ec2-user' for Amazon Linux)
    private_key = file("dovekey") # Ensure this is the private key corresponding to the public key in aws_key_pair
    host        = self.public_ip  # Use the public IP for SSH connection
  }
}

# Outputs for the instance's public and private IP addresses
output "PublicIP" {
  value = aws_instance.dove-inst.public_ip
}

output "PrivateIP" {
  value = aws_instance.dove-inst.private_ip
}
