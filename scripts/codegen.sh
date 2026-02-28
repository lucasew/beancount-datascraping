#!/usr/bin/env bash
set -e
set -x

# Run all fetch scripts in parallel
find . -name fetch -type f -executable -print0 | xargs -0 -P 4 -I {} sh -c '"{}"'
