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
    --path stac_fastapi/testdata/ \
    --path .dockerignore \
    --path .gitignore \
    --path .pre-commit-config.yaml \
    --path Makefile \
    --path CHANGES.md \
    --path CONTRIBUTING.md \
    --path RELEASING.md \
    --path LICENSE \
    --path VERSION \
    --path pyproject.toml \
    --path nginx.conf \
    --path docker-compose.yml \
    --path docker-compose.docs.yml \
    --path docker-compose.nginx.yml \
    --path docker/Dockerfile \
    --path .github \
    --path scripts \
    --path docs/ \
    --path mkdocs.yml \
    --path-rename "stac_fastapi/$name/:" \
    --path-rename stac_fastapi/testdata:testdata \
    --path-rename docker/Dockerfile:Dockerfile

cat <<EOF

========================
== git-filter-repo OK ==
========================
EOF