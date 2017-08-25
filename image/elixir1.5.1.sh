#!/bin/bash
set -e
source /elixir_build/buildconfig
source /elixir_build/elixir_prep.sh
source /elixir_build/elixir_install
set -x

ELIXIR_VERSION=1.5.1
ELIXIR_DOWNLOAD_SHA256=9a903dc71800c6ce8f4f4b84a1e4849e3433e68243958fd6413a144857b61f6a

elixir_install
