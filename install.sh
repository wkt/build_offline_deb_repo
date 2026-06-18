#!/bin/bash

SELF=$(readlink -f $0)
SELF_DIR=$(dirname ${SELF})


PACK_LIST=/etc/apt/sources.list.d/pack_offline_@TM@.list
TM=@TM@

_backup(){

for f in /etc/apt/sources.list /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources
do
	test -f "${f}" || continue
	bf="${f}.@TM@.bak"
	mv "${f}" "${bf}"
done
}

_exit(){

	rm -rf "/etc/apt/sources.list.d/pack_offline_@TM@.list"
	for bf in /etc/apt/sources.list.@TM@.bak /etc/apt/sources.list.d/*.${TM}.bak
	do
		f=${bf%.${TM}.bak}
		mv ${bf} ${f}
	done
	exit $1
}


cd ${SELF_DIR}

uid=$(id -u)
test "x${uid}" != "x0" && {
	echo ""
	echo "    Please run as this script as root"
	echo ""
	exit 1
}


rm -rf /etc/apt/sources.list.d/pack_offline_*.list
if test -f ${SELF_DIR}/Packages.gz ;then
cat <<__EOF > ${PACK_LIST}
deb [allow-insecure=true trusted=true] file://${SELF_DIR} ./
__EOF

fi

_backup

rm -rf /var/lib/apt/lists/*


apt-get update || _exit 1

apt-get install --yes --no-install-recommends @PACKAGE_NAMES@ || _exit 2
_exit 0

