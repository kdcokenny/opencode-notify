#!/usr/bin/env bash

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$ROOT/files"
ln -sfn ../src "$ROOT/files/src"

ocx build . --cwd "$ROOT"
