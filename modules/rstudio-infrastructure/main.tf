# Deploy local SSH Key to Exoscale for
resource "cloudstack_ssh_keypair" "rstudio-ssh-key" {
  name       = "rstudio-server-ssh-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# Create a seperate Security Group and Rules to handle network rules
resource "cloudstack_security_group" "rstudio-security-group" {
  name        = "rstudio-security-group"
  description = "Allow access to rstudio, through ssh and web"
}

resource "cloudstack_security_group_rule" "rstudio-security-group-rules" {
  security_group_id = "${cloudstack_security_group.rstudio-security-group.id}"

  rule {
    cidr_list = ["0.0.0.0/0"]
    protocol  = "tcp"
    ports     = ["22", "8787"]
  }
}

# Create  Linux Ubuntu 16.04 LTS 64-bit 100GB as underlying infrastructure for RStudio Nodes
resource "cloudstack_instance" "rstudio-nodes" {
  name               = "rstudio-node0${count.index}"
  template           = "922f4a28-eab8-4716-9381-6dce8b106b95"
  service_offering   = "Medium"
  zone               = "at-vie-1"
  security_group_ids = ["${cloudstack_security_group.rstudio-security-group.id}"]
  keypair            = "${cloudstack_ssh_keypair.rstudio-ssh-key.id}"
  count              = 2
}

# Template for ansible inventory
data "template_file" "ansible-inventory" {
  template = "${file("ansible-inventory.tpl")}"

  vars {
    rstudio-nodes = "${replace(join(",", cloudstack_instance.rstudio-nodes.*.ip_address), "," , "\n") }"
  }
}

# Create inventory file
resource "null_resource" "create-ansible-inventory" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers {
    template = "${data.template_file.ansible-inventory.rendered}"
  }

  provisioner "local-exec" {
    command = "echo \"${data.template_file.ansible-inventory.rendered}\" > inventory"
  }
}
