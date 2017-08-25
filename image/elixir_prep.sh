#!/bin/bash
set -ex
# Prep erlang
curl -fSL -o erlang-solutions_1.0_all.deb https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
dpkg -i erlang-solutions_1.0_all.deb
rm -rf erlang-solutions_1.0_all.deb

locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8
echo '/root' > /etc/container_environment/HOME
packages='build-essential esl-erlang'
