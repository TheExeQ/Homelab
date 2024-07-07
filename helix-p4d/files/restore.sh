#!/bin/bash

if [ ! -d "$P4ROOT/etc" ]; then
    echo "Error: perforce server is not present, create an empty server before restoring"
    exit 255
fi

## Assign checkpoint and journal variables
CKP_BAK=$P4CKP/$P4LATESTCKP
JNL_BAK=$P4CKP/$P4LATESTJNL

## Check if the arguments are valid file paths
if [ ! -e "$CKP_BAK" ]; then
    echo "Error: $CKP_BAK is not a valid file path."
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

p4d $P4CASE -r $P4DATABASE -jr $CKP_BAK $JNL_BAK
p4d $P4CASE -r $P4DATABASE -xu

## Make sure perforce has permission to all files
chown -R perforce:perforce $P4HOME

## Set key environment variables
p4d $P4CASE -r $P4DATABASE "-cset ${P4NAME}#server.depot.root=${P4DEPOTS}"
p4d $P4CASE -r $P4DATABASE "-cset ${P4NAME}#journalPrefix=${P4CKP}/${JNL_PREFIX}"

p4d $P4CASE -r $P4DATABASE -p $P4TCP -L $P4LOG -J $P4JOURNAL -d