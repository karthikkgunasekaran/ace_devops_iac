region = "ap-south-1"
owner  = "your_email@domain.com"

key_name = "ace_devops_labs_key"

ec2_config = {
  ami                         = "ami-05fa46471b02db0ce"
  instance_type               = "t2.large"
  ssh_key_name                = "ace_devops_labs_key"
  name                        = "ace_devOps_labs_01"
  associate_public_ip_address = true
}
