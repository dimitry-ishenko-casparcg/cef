#!/bin/sh
set -eu
die() { echo "$@" >&2; exit 1; }

apis=$(sed -n "s/^#define CEF_API_VERSION_\([0-9]*\) .*/\1/p" "$1" | awk '$1 < 999998')
[ -n "$apis" ] && echo "$apis" || die "no stable APIs found in $1"
