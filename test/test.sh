#!/bin/bash
set -o pipefail

function ok()
{
	echo "  OK"
}

function fail()
{
	echo "  FAIL"
	exit 1
}

echo "Checking whether all services are running..."
services=`sv status /etc/service/*`
status=$?
if [[ "$status" != 0 || "$services" = "" || "$services" =~ down ]]; then
	fail
else
	ok
fi

echo "Checking Elixir is installed and has the proper version..."
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
elixir=$(elixir -v | awk 'FNR == 3 { print $2 }')

if [[ $elixir == $1 ]]; then
	ok
else
	echo "Wrong version of elixir installed!"
	fail
fi
