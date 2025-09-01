terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
}

provider "proxmox" {
  pm_user = "root@pam"
  pm_password = "1qaz!QAZ"
  pm_api_url = "https://192.168.30.2:8006/api2/json"
  pm_tls_insecure = true
}

resource "proxmox_lxc" "k8s-cp-1" {
  cores = 2
  hostname = "k8s-cp-1"
  memory = 4096
  ostemplate = "local:vztmpl/ubuntu-25.04-standard_25.04-1.1_amd64.tar.zst"
  password = "1qaz!QAZ"
  swap = 0
  target_node = "hikari"
  unprivileged = true
  vmid = 100
  features {
    nesting = true
  }
  network {
    bridge = "vmbr0"
    firewall = true
    ip = "192.168.30.100/24"
    name = "eth0"
  }
  rootfs {
    size = "16G"
    storage = "local-lvm"
  }
}
