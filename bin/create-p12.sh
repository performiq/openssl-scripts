#!/bin/sh
#
#  Notes:
#
#    Also called .pfx files.
#
# -----------------------------------------------------------------------------

# set -x

if [ $# -ne 1 ] ; then
    echo "Specify the name or domain to be tested"
    ls -l *.p12 *.txt
    exit 1
fi

NAME=`echo $1 | sed 's/.p12//'`

if [ -f passphrase.txt ] ; then
    echo "This script should be run in a folder containing the key's passphrase.txt"
    exit 2
fi

if [ -f ${NAME}.p12 ] ; then
    if [ -f passphrase.txt ] ; then
        echo "Using pass-phrase for key:"
        cat passphrase.txt
        echo
        if [ -f ca.crt ] ; then
	    openssl pkcs12 -inkey ${NAME}.key -in ${NAME}.crt -certfile ca.crt  -export -out ${NAME}.p12
        else
	    openssl pkcs12 -inkey ${NAME}.key -in ${NAME}.crt                   -export -out ${NAME}.p12
        fi
        echo
    else
        openssl pkcs12 -inkey ${NAME}.key -in ${NAME}.crt -export -out ${NAME}.p12
    fi
else
    echo "No file - ${NAME}.p12 - found.  Did you mean:
    ls -l *.p12
fi

