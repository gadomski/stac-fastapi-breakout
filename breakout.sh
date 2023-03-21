#!/usr/bin/env sh

set -e

if [ $# -ne 3 ]; then
   echo "ERROR: Invalid number of arguments"
   echo "USAGE: $0 SRC DST {pgstac|sqlalchemy}"
   exit 1
fi

name=$3
directory="$2/stac-fastapi-$name"
rm -rf "$directory"
git clone --branch main --no-hardlinks --no-local --single-branch "$1" "$directory"
cd "$directory"
git filter-repo \
    --path "stac_fastapi/$name/" \
    --path .dockerignore \
    --path .gitignore \
    --path .pre-commit-config.yaml \
    --path Makefile \
    --path CHANGES.md \
    --path CONTRIBUTING.md \
    --path LICENSE \
    --path VERSION \
    --path pyproject.toml \
    --path docker-compose.docs.yml \
    --path docker-compose.nginx.yml \
    --path docker/Dockerfile \
    --path "docker/Dockerfile.$name" \
    --path "docker/docker-compose.$name.yml" \
    --path .github \
    --path scripts \
    --path-rename "stac_fastapi/$name/:" \
    --path-rename docker/Dockerfile:Dockerfile.dev \
    --path-rename "docker/Dockerfile.$name:Dockerfile" \
    --path-rename "docker/docker-compose.$name.yml:docker-compose.yml"

cat <<EOF

========================
== git-filter-repo OK ==
========================

You're not done yet!!!

1. We couldn't automagically fix the content of the following files, so you're
   going to have to yourself:
      - Makefile
      - Dockerfile.dev
      - docker-compose.nginx.yaml
2. Manually add the "load joplin" section back to docker-compose.yaml
3. Manually change docker-compose.yaml to reference Dockerfile.dev instead of
   Dockerfile.
4. Go through the whole repo and make sure tests pass, there aren't any dangling
   references to other backends, etc.
EOF