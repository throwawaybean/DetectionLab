
#########################################
#  ESXI Provider host/login details
#########################################
#
#   Use of variables here to hide/move the variables to a separate file
#
provider "esxi" {
  esxi_hostname = "10.172.60.40"
  esxi_hostport = "22"
  esxi_username = "root"
  esxi_password = "Password1"
}

#########################################
#  ESXI Guest resource
#########################################
resource "esxi_guest" "logger" {
  guest_name = "logger"
  disk_store = "datastore1"
  guestos    = "ubuntu-64"

  boot_disk_type = "thin"

  memsize            = "4096"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"
  clone_from_vm = "Ubuntu2004"

    provisioner "remote-exec" {
    inline = [
      "sudo ifconfig eth0 up && echo 'eth0 up' || echo 'unable to bring eth0 interface up",
      "sudo ifconfig eth1 up && echo 'eth1 up' || echo 'unable to bring eth1 interface up"
    ]

    connection {
      host        = self.ip_address
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
    }
  }
  # This is the network that bridges your host machine with the ESXi VM
  # If this interface doesn't provide connectivity, you will have to uncomment
  # the interface below and add a virtual network that does
  network_interfaces {
    virtual_network = "VM Network"
    mac_address     = "00:00:00:00:6a:2b"
    nic_type        = "e1000"
  }
  # This is the local network that will be used for 192.168.56.x addressing
  network_interfaces {
    virtual_network = "HostOnly Network"
    mac_address     = "00:00:00:00:5a:2b"
    nic_type        = "e1000"
  }
  # OPTIONAL: Uncomment out this interface stanza if your vm_network doesn't 
  # provide internet access
  # network_interfaces {
  #  virtual_network = var.nat_network
  #  mac_address     = "00:50:56:a3:b1:c3"
  #  nic_type        = "e1000"
  # }
  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}

resource "esxi_guest" "dc" {
  guest_name = "dc"
  disk_store = "datastore1"
  guestos    = "windows9srv-64"

  boot_disk_type = "thin"

  memsize            = "4096"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"
  clone_from_vm = "WindowsServer2016"
  # This is the network that bridges your host machine with the ESXi VM
  network_interfaces {
    virtual_network = "VM Network"
    mac_address     = "00:00:00:00:6a:2e"
    nic_type        = "e1000"
  }
  # This is the local network that will be used for 192.168.56.x addressing
  network_interfaces {
    virtual_network = "HostOnly Network"
    mac_address     = "00:00:00:00:5a:2e"
    nic_type        = "e1000"
  }
  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}

resource "esxi_guest" "wef" {
  guest_name = "wef"
  disk_store = "datastore1"
  guestos    = "windows9srv-64"

  boot_disk_type = "thin"

  memsize            = "2048"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"
  clone_from_vm = "WindowsServer2016"
  # This is the network that bridges your host machine with the ESXi VM
  network_interfaces {
    virtual_network = "VM Network"
    mac_address     = "00:00:00:00:6a:2d"
    nic_type        = "e1000"
  }
  # This is the local network that will be used for 192.168.56.x addressing
  network_interfaces {
    virtual_network = "HostOnly Network"
    mac_address     = "00:00:00:00:5a:2d"
    nic_type        = "e1000"
  }
  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}

resource "esxi_guest" "win10" {
  guest_name = "win10"
  disk_store = "datastore1"
  guestos    = "windows9-64"

  boot_disk_type = "thin"

  memsize            = "2048"
  numvcpus           = "2"
  resource_pool_name = "/"
  power              = "on"
  clone_from_vm = "Windows10"
  # This is the network that bridges your host machine with the ESXi VM
  network_interfaces {
    virtual_network = "VM Network"
    mac_address     = "00:00:00:00:6a:2c"
    nic_type        = "e1000"
  }
  # This is the local network that will be used for 192.168.56.x addressing
  network_interfaces {
    virtual_network = "HostOnly Network"
    mac_address     = "00:00:00:00:5a:2c"
    nic_type        = "e1000"
  }
  guest_startup_timeout  = 45
  guest_shutdown_timeout = 30
}
