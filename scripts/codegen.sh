#!/usr/bin/env bash
set -u

# Run all fetch scripts in parallel
# We ignore errors from individual scripts to ensure the pipeline proceeds.
# The Janitor or maintainers should fix broken fetchers.
# shellcheck disable=SC2016
find . -name fetch -type f -executable -print0 | xargs -0 -P 4 -I {} bash -c '"$1" || echo "⚠️  Warning: $1 failed with exit code $?"' _ "{}"
