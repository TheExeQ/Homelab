#!/bin/bash

if [ ! -d "$P4ROOT/etc" ]; then
    echo "Error: perforce server is not present, create an empty server before restoring"
    exit 255
fi

## Assign checkpoint and journal variables
CP_BAK=$P4CKP/$P4RECOVERCP
JNL_BAK=$P4CKP/$P4RECOVERJNL

## Check if the arguments are valid file paths
if [ ! -e "$CP_BAK" ]; then
    echo "Error: $CP_BAK is not a valid file path."
    exit 255
fi

if [ ! -e "$CP_BAK" ]; then
    echo "Error: Checksum $CP_BAK.md5 could not be found."
    exit 255
fi

if [ ! -e "$JNL_BAK" ]; then
    echo "Error: $JNL_BAK is not a valid file path."
    exit 255
fi

## Remove current data base
rm -rf $P4DATABASE/*

## Set server name
echo $P4NAME > $P4DATABASE/server.id

p4d $P4CASE -r $P4DATABASE -jr $CP_BAK $JNL_BAK

p4d $P4CASE -r $P4DATABASE -p $P4TCP -L $P4LOG -J $P4JOURNAL -d