#!/bin/sh
set -eu

header=$1
name=$2
arch=$3
major=$4

root=/usr/lib/cef/$arch

install=""
remove=""
for api in $(debian/get-apis.sh "$header"); do
    install="$install
    update-alternatives --install $root/api$api cef-api$api $root/$major $major"
    remove="$remove
    update-alternatives --remove cef-api$api $root/$major"
done

cat > "debian/$name.postinst" <<EOF
#!/bin/sh
set -e

if [ "\$1" = configure ]; then$install
fi

#DEBHELPER#
EOF

cat > "debian/$name.prerm" <<EOF
#!/bin/sh
set -e

if [ "\$1" != upgrade ]; then$remove
fi

#DEBHELPER#
EOF
