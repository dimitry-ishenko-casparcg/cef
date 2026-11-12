#!/bin/sh
set -eu

header=$1
library=$2

provides=""
dev_provides=""

for api in $(debian/get-apis.sh "$header"); do
    provides="${provides:+$provides, }libcef-api$api"
    dev_provides="${dev_provides:+$dev_provides, }libcef-api$api-dev"
done

echo "cef:Provides=$provides" >> "debian/$library.substvars"
echo "cef:DevProvides=$dev_provides" >> "debian/$library-dev.substvars"
