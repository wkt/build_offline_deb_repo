#!/bin/bash

SELF=$(readlink -f $0)
SELF_DIR=$(dirname ${SELF})

TM=$(date '+%s')

PACK_LIST=/etc/apt/sources.list.d/pack_${TM}.list
LIST_F=/etc/apt/sources.list
LIST_B=/etc/apt/sources.list.${TM}

cd ${SELF_DIR}

uid=$(id -u)
test "x${uid}" != "x0" && {
	echo ""
	echo "    Please run as this script as root"
	echo ""
	exit 1
}


if test -f ${SELF_DIR}/Packages.gz ;then
cat <<__EOF > ${PACK_LIST}
deb [allow-insecure=true trusted=true] file://${SELF_DIR} ./
__EOF

fi

rm -rf /var/lib/apt/lists/*

mv ${LIST_F} ${LIST_B}
apt-get update
mv ${LIST_B} ${LIST_F}

apt-get install --yes @PACKAGE_NAMES@
rm -rf ${PACK_LIST}
