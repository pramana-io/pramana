#!/usr/bin/env bash

set -euo pipefail

MIN_GO_MINOR=22  
info() { printf '\033[0;34m[info]\033[0m %s\n' "$1"; }
ok()   { printf '\033[0;32m[ ok ]\033[0m %s\n' "$1"; }
fail() { printf '\033[0;31m[fail]\033[0m %s\n' "$1"; exit 1; }

command -v go >/dev/null 2>&1 || fail "Go not installed. Get Go 1.${MIN_GO_MINOR}+ from https://go.dev/dl/"
GO_VERSION="$(go version | awk '{print $3}' | sed 's/go//')"
GO_MINOR="$(echo "$GO_VERSION" | cut -d. -f2)"
[ "$GO_MINOR" -ge "$MIN_GO_MINOR" ] || fail "Go $GO_VERSION found; need 1.${MIN_GO_MINOR}+. Update from https://go.dev/dl/"
ok "Go $GO_VERSION"

command -v git >/dev/null 2>&1 || fail "git not installed."
ok "git $(git --version | awk '{print $3}')"

info "Downloading module dependencies..."
go mod download
ok "Dependencies downloaded."

info "Building..."
go build -o /dev/null ./...
ok "Build succeeded."

echo
ok "Setup complete. Try:  go run ./cmd/pramana version"