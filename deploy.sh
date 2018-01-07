#!/bin/bash

set -eu

SERVER="narfi.net"
DIR="/srv/www/docs.helfertool.org/"

# switch to directory of script
dir="$(readlink -f $(dirname "$0"))"
cd "$dir"

# compile page
make clean
make html

# copy to server
rsync -r --delete build/html/ "$SERVER:$DIR/"
