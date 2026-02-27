#!/usr/bin/env bash
set -e

# Create bin directory
mkdir -p ./bin

# Install workspaced
echo "Installing workspaced..."
# Correct URL for 0.1.5 (using 0.1.5 instead of v0.1.5 as per curl check)
URL="https://github.com/lucasew/workspaced/releases/download/0.1.5/workspaced-linux-amd64"
curl -fL -o ./bin/workspaced "$URL"
chmod +x ./bin/workspaced

echo "workspaced installed to ./bin/workspaced"
./bin/workspaced --version
