#!/bin/bash
set -e
source /elixir_build/buildconfig
set -x

/elixir_build/elixir_prep.sh

if [[ "$elixir132" = 1 ]]; then /elixir_build/elixir1.3.2.sh; fi
if [[ "$elixir151" = 1 ]]; then /elixir_build/elixir1.5.1.sh; fi

/elixir_build/cleanup.sh
