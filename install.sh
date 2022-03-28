#!/bin/bash

SELF=$(readlink -f $0)
SELF_DIR=$(dirname ${SELF})
PACK_LIST=/etc/apt/sources.list.d/pack.list
cd ${SELF_DIR}
if test -f ${SELF_DIR}/Packages.gz ;then
cat <<__EOF > ${PACK_LIST}
deb [allow-insecure=true trusted=true] file://${SELF_DIR} ./
__EOF

fi

rm -rf /var/lib/apt/lists/*
mv /etc/apt/sources.list{,.bak}
apt-get update
mv /etc/apt/sources.list{.bak,}
apt-get install --yes @PACKAGE_NAMES@
rm -rf ${PACK_LIST}
