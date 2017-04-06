#!/bin/bash

set -euo pipefail

# Ensure local Apache is stopped
PROCS=`ps auxw | grep -E '[h]ttpd|[a]pache' | wc -l`

if [ "$PROCS" != "0" ]; then
  echo -e "\n*** Enter your password to sudo and stop local Apache (if prompted)...\n"
  sudo apachectl stop
fi

# Start PBJ containers
mkdir -p ~/pbj
mkdir -p ~/pbj-db

docker-compose up
