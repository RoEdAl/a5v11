#!/bin/bash

ImageBuilderDir=/lede-imagebuilder-17.01.2-ramips-rt305x.Linux-x86_64

get_abs_dir() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)"
  fi
}

get_profile_name() {
  FN=$(basename $1 .sh)
  echo "${FN##build_}"
}


is_array() {
    local variable_name=$1
    [[ "$(declare -p $variable_name 2>/dev/null)" =~ "declare -a" ]]
}

# retrieve the full pathname of the called script
SCRIPT_DIR=$(get_abs_dir $0)
PROFILE_NAME=$(get_profile_name $0)

echo "Profile: $PROFILE_NAME"

if [ ! -d "$SCRIPT_DIR$ImageBuilderDir" ]; then
    echo "Please install and extract LEDE image builder for rampis-rt305x"
    exit 1
fi

PACKAGES_DESC=$SCRIPT_DIR/${PROFILE_NAME}_packages

. $PACKAGES_DESC || exit 1

is_array packages || {
    echo 'Packages array not specified'
    exit 1
}

make image -C "$SCRIPT_DIR$ImageBuilderDir" PROFILE=a5-v11 PACKAGES="${packages[*]}" FILES="$SCRIPT_DIR/$PROFILE_NAME/" BIN_DIR="$SCRIPT_DIR/$PROFILE_NAME.lede-bin"
