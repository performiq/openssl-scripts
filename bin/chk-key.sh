#!/bin/sh

# set -x

if [ $# -ne 1 ] ; then
    echo "Specify the name or domain to be tested"
    ls -l *.key *.txt
    exit 1
fi

NAME=`echo $1 | sed 's/.key//'`

if [ -f passphrase.txt ] ; then
    echo "This script should be run in a folder containing the key's passphrase.txt"
    exit 2
fi

if [ -f ${NAME}.key ] ; then
    if [ -f passphrase.txt ] ; then
        echo "Using pass-phrase for key:"
        cat passphrase.txt
        echo
	openssl rsa -in ${NAME}.key -noout -text --passin file:passphrase.txt
        echo
        echo
	openssl rsa -in ${NAME}.key -check --passin file:passphrase.txt
        echo
    else
        openssl rsa -in ${NAME}.key -noout -text
    fi
else
    echo "No file - ${NAME}.key - found.  Did you mean:
    ls -l *.key
fi

