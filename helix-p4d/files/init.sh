#!/bin/bash

# Setup directories
mkdir -p "$P4ROOT"
mkdir -p "$P4DEPOTS"
mkdir -p "$P4CKP"

if [ -n "$P4RECOVERCP" ] && [ -n "$P4RECOVERJNL" ]; then
    echo "Restoring checkpoint..."
	restore.sh
else
	echo "Create empty or start existing server..."
	setup.sh
fi

p4 login <<EOF
$P4PASSWD
EOF

## Give perforce user permission to directories
chown perforce:perforce "$P4ROOT"
chown perforce:perforce "$P4DEPOTS"
chown perforce:perforce "$P4CKP"

echo "Perforce Server starting..."
until p4 info -s 2> /dev/null; do sleep 1; done
echo "Perforce Server [RUNNING]"

## Remove all triggers
echo "Triggers:" | p4 triggers -i
