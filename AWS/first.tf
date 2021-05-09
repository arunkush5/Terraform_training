provider "aws" {
    profile = "terra_user"
    region = "ap-south-1"
}

resource "aws_instance" "TfOS" {
    ami = "ami-010aff33ed5991201"
    instance_type = "t2.micro"
    tags = {
      "Name" = "TerraOS"
    }
}

resource "aws_ebs_volume" "tfvol"{
    availability_zone = aws_instance.TfOS.availability_zone
    size = 10
}

resource "aws_volume_attachment" "tfhdd" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.tfvol.id
  instance_id = aws_instance.TfOS.id
}

output "infraids" {
    value = "This is my ${aws_instance.TfOS.id} instance created in this ${aws_instance.TfOS.availability_zone} region and this ${aws_ebs_volume.tfvol.id} volume attached with this id ${aws_volume_attachment.tfhdd.id} this is my Private IP to connect me ${aws_instance.TfOS.private_ip}"
}