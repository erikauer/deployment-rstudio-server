# Create CentOS as underlying infrastructure for RStudio
resource "cloudstack_instance" "rstudio-node" {
  name             = "rstudio-node0${count.index}"
  template         = "84e46485-02dc-44dd-8632-9dd52ddcac92"
  service_offering = "Medium"
  root_disk_size   = 100
  zone             = "at-vie-1"
  count            = 1
}
