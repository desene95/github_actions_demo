data "aws_iam_policy_document" "current_config" {
  # No specific configuration is needed for this data source
}

 data "terraform_remote_state" "pub_subnet"{
      backend = "s3"
      config = {
      bucket         = "ghubactions"
      key            = "orchestration/pub_subnet/terraform.tfstate"
      region         = "ca-central-1"  # Modify this to match your S3 bucket's region
      #encrypt        = true
      #shared_credentials_file = "/path/to/aws/credentials/file"  # Optional, if using shared credentials
    }
}

 data "terraform_remote_state" "sg"{
      backend = "s3"
      config = {
      bucket         = "ghubactions"
      key            = "orchestration/vpc/terraform.tfstate"
      region         = "ca-central-1"  # Modify this to match your S3 bucket's region
      #encrypt        = true
      #shared_credentials_file = "/path/to/aws/credentials/file"  # Optional, if using shared credentials
    }
}

resource "aws_instance" "ec2_instance" {
  ami           = "ami-06873c81b882339ac"
  instance_type = "t2.micro"
  associate_public_ip_address = var.assoc_pub_ip
  tags = {
    "Name" = var.ec2_name
  }
  subnet_id     = data.terraform_remote_state.pub_subnet.outputs.subnet_id
  security_groups = [data.terraform_remote_state.sg.outputs.sg_id]
}

output "ec2_id"{
    value   =   aws_instance.ec2_instance.id
}