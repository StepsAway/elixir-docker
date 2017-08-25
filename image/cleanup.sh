#!/bin/bash
set -e
source /elixir_build/buildconfig
set -x

apt-get clean
rm -rf /elixir_build
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

rm -f /etc/ssh/ssh_host_*
