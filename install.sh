#!/bin/bash

SELF=$(readlink -f $0)
SELF_DIR=$(dirname ${SELF})

cd ${SELF_DIR}
if test -f ${SELF_DIR}/Packages.gz ;then
cat <<__EOF >/etc/apt/sources.list.d/pack.list
deb [allow-insecure=true] file://${SELF_DIR} ./
__EOF

fi

rm -rf /var/lib/apt/lists/*
apt-get update || exit 1
apt-get install --yes @PACKAGE_NAMES@
