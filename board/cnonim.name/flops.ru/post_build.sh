#!/bin/sh
# prompt root password
sed -i -e "s,^root:[^:]*:,root:$(mkpasswd -m sha-512):," $1/etc/shadow

# remove /host directory
rm -rf $1/host
mkdir $1/host