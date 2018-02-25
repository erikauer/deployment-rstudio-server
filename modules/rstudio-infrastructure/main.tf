# Create CentOS as underlying infrastructure for RStudio
resource "cloudstack_instance" "rstudio-nodes" {
  name             = "rstudio-node0${count.index}"
  template         = "84e46485-02dc-44dd-8632-9dd52ddcac92"
  service_offering = "Medium"
  zone             = "at-vie-1"
  count            = 2
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