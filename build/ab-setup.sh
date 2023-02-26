#!/bin/bash

function log {
   echo "$(date) $(hostname): $1"
}

# Check if the operating system is using dnf
if command -v dnf >/dev/null 2>&1; then
    log "dnf package manager detected"
else
    log "This script is only intended to run on systems that use the dnf package manager"
    exit 1
fi

log "installation starts..."
dnf install -y yum-utils device-mapper-persistent-data lvm2

log "install docker"
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io

log "start docker"
systemctl enable docker || echo "docker initialization failed"
systemctl start docker 

log "install terraform"
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
dnf -y install terraform

log "git"
