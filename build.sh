#!/bin/bash

# ref: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -euxo pipefail

# get xcaddy:latest
go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest

# build
xcaddy build --with github.com/mholt/caddy-l4

# Docker
TMP=$(mktemp)
echo "Docker context: $TMP"
mv caddy $TMP
cp Dockerfile.tmpl $TMP/Dockerfile
(cd $TMP; docker build . -t geropl/caddy:2.4.3-alpine-l4)