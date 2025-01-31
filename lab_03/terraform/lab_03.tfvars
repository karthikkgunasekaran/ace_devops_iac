region = "ap-south-1"
owner  = "your_email@domain.com"

key_name = "lab_03_key"

ec2_config = {
  ami                         = "ami-05fa46471b02db0ce"
  instance_type               = "t2.micro"
  ssh_key_name                = "lab_03_key"
  name                        = "lab_03"
  associate_public_ip_address = true
}
