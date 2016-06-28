#!/bin/sh

CONTAINER_VER="1.0"
PRODUCT_NAME="swupdate"
SWUPDATE_FILES_PATH="${PWD}/swupdate"
FILES="sw-description sw-description.sig"

compute_hash(){
	names=$(cat "${SWUPDATE_FILES_PATH}/sw-description" | sed -n '/@/p' | cut -d@ -f2 | uniq )
	cp ${SWUPDATE_FILES_PATH}/sw-description ${BINARIES_DIR}/sw-description ;
	for name in $names;do
	FILES+=" $name";
	cp "${SWUPDATE_FILES_PATH}/$name" "${BINARIES_DIR}/$name" ;
	sha256=$(sha256sum "${BINARIES_DIR}/$name" | cut -d ' ' -f1 )
	sed -i "s/@$name/\"$sha256\";/"  "${BINARIES_DIR}/sw-description" ; done ;
}

create_swdescription_sig(){
	if test -f "${SWUPDATE_FILES_PATH}/priv.pem"
	then
		openssl dgst -sha256 -sign "${SWUPDATE_FILES_PATH}/priv.pem" "${BINARIES_DIR}/sw-description" > "${BINARIES_DIR}/sw-description.sig"
	else
		echo "Private key doesn't exist"
		exit 1
	fi
}

create_swu(){
	cd ${BINARIES_DIR}
	for file in $FILES; do
		echo $file;done | cpio -ov -H crc >  ${PRODUCT_NAME}_${CONTAINER_VER}.swu
	rm sw-description sw-description.sig
}

compute_hash
create_swdescription_sig ;
create_swu
exit 0
