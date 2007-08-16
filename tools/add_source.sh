#!/bin/sh
# Nico Schottelius
# 2007-08-16
# Written for Netstream (www.netstream.ch)
# Creates a source from standard values specified in
# /etc/ccollect/defaults/sources

# standard values
CCOLLECT_CONF="${CCOLLECT_CONF:-/etc/ccollect}"
CSOURCES="${CCOLLECT_CONF}/sources"
CDEFAULTS="${CCOLLECT_CONF}/defaults"
SCONFIG="${CDEFAULTS}/sources"

exclude="${SCONFIG}/exclude"
summary="${SCONFIG}/summary"
intervals="${SCONFIG}/intervals"

pre_exec="${SCONFIG}/pre_exec"
post_exec="${SCONFIG}/post_exec"

rsync_options="${SCONFIG}/rsync_options"

verbose="${SCONFIG}/verbose"
vverbose="${SCONFIG}/very_verbose"

# options that we simply copy over
standard_opts="exclude summary intervals pre_exec post_exec rsync_options verbose very_verbose"

# options not in standard ccollect, used only for source
# generation
src_prefix="${SCONFIG}/source_prefix"
src_postfix="${SCONFIG}/source_postfix"
destination_base="${SCONFIG}/destination_base"

self=$(basename $0)

# functions first
_echo()
{
   echo "${self}> $@"
}

_exit_err()
{
   _echo "$@"
   rm -f "$TMP"
   exit 1
}

# argv
if [ $# -lt 1 ]; then
   _exit_err "<hostnames to create sources for>"
fi

while [ $# -gt 0 ]; do

done

# create source
# Tests
if [ -e "${fullname}" ]; then
   _echo "${fullname} already exists. Aborting."
   exit 2
fi

# copy standard files

# create source

# create destination directory


# Create
_echo "Creating ${fullname} ..."
mkdir -p "${fullname}" || exit 3

echo "root@${source}:/" > "${fullname}/source"
cat << eof > "${fullname}/exclude" || exit 4
/dev/*
/proc/*
/tmp/*
eof

# Destination
if [ -e "${destination}" ]; then
   if [ ! -d "${destination}" ]; then
      echo "${destination} exists, but is not a directory. Aborting."
      exit 5
   fi
else
   _echo "Creating ${destination} ..."
   mkdir -p "${destination}" || _exit_err "Failed to create ${destination}."
fi

ln -s "${destination}" "${fullname}/destination" || \
   _exit_err "Failed to link \"${destination}\" to \"${fullname}/destination\""

# finish
_echo "Added some default values, please verify \"${fullname}\"."
_echo "Finished."
