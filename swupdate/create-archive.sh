#!/bin/sh
# Script to create a signed .swu archive due to the sw-description file.
# All files specified in sw-description need to be in SWUPDATE_FILES_PATH
# except images which are in BINARIES_DIR
# This script does not create sw-description

# Variables
VERSION="1.0"
EMERGENCY_WORD="CRITICAL"
PRODUCT_NAME="rpi_swupdate"
SWUPDATE_FILES_PATH="${BR2_EXTERNAL}/swupdate"
FILES="sw-description sw-description.sig"

# Add hash in sw-description. 
compute_hash(){
	names=$(cat "${SWUPDATE_FILES_PATH}/sw-description" | sed -n '/@/p' | cut -d@ -f2 | uniq )
	cp ${SWUPDATE_FILES_PATH}/sw-description ${BINARIES_DIR}/sw-description ;
	for name in $names;do
	FILES+=" $name";
	cp "${SWUPDATE_FILES_PATH}/$name" "${BINARIES_DIR}/$name" ;
	sha256=$(sha256sum "${BINARIES_DIR}/$name" | cut -d ' ' -f1 )
	sed -i "s/@$name/\"$sha256\";/"  "${BINARIES_DIR}/sw-description" ; done ;
}

# Create sw-description.sig. A private key is needed
create_swdescription_sig(){
	if test -f "${SWUPDATE_FILES_PATH}/priv.pem"
	then
		openssl dgst -sha256 -sign "${SWUPDATE_FILES_PATH}/priv.pem" "${BINARIES_DIR}/sw-description" > "${BINARIES_DIR}/sw-description.sig"
	else
		echo "Private key doesn't exist"
		exit 1
	fi
}

# Create .swu archive 
create_swu(){
	cd ${BINARIES_DIR}
	for file in $FILES; do
		echo $file;done | cpio -ov -H crc >  ${PRODUCT_NAME}-${VERSION}-${EMERGENCY_WORD}.swu
  if [ -f "${PRODUCT_NAME}-${CONTAINER_VER}-${EMERGENCY_WORD}.swu" ]
  then 
    echo "L'archive ${PRODUCT_NAME}-${VERSION}-${EMERGENCY_WORD}.swu a bien été créée dans ${BINARIES_DIR}"
  fi

	rm sw-description sw-description.sig
}

compute_hash
create_swdescription_sig ;
create_swu

exit 0
