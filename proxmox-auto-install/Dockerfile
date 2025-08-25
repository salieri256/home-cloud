FROM debian:12.11-slim

RUN apt update && apt install -y wget xorriso
RUN wget http://download.proxmox.com/debian/pve/dists/bookworm/pve-no-subscription/binary-amd64/proxmox-auto-install-assistant_8.4.6_amd64.deb -O proxmox-auto-install-assistant.deb && dpkg -i proxmox-auto-install-assistant.deb
WORKDIR /workspace
CMD bash
