#!/bin/bash

# ref: https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425
set -euxo pipefail

# build context
TMP=$(mktemp -d)
echo "Build context: $TMP"
cp ../Dockerfile.tmpl $TMP/Dockerfile

# build
VERSION="v2.4.3"
(cd $TMP && \
    xcaddy build $VERSION \
        --with github.com/mholt/caddy-l4)

# Docker
(cd $TMP && docker build --build-arg VERSION=$VERSION . -t geropl/caddy:$VERSION-alpine-l4)