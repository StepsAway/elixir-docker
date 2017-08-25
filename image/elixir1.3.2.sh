#!/bin/bash
set -e
source /elixir_build/buildconfig
source /elixir_build/elixir_prep.sh
source /elixir_build/elixir_install
set -x

ELIXIR_VERSION=1.3.2
ELIXIR_DOWNLOAD_SHA256=45fdb9464b0fbe44c919482f1247740cc9c5d399280ef07e386aa7402b085be7

elixir_install
