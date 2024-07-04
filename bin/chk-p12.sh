#!/bin/sh

# set -x

if [ $# -ne 1 ] ; then
    echo "Specify the name or domain to be tested"
    ls -l *.crt
    exit 1
fi

NAME=`echo $1 | sed 's/.p12//'`

if [ -f ${NAME}.p12 ] ; then
    openssl pkcs12 -info -in ${NAME}.p12 -nodes
else
    echo "No file - ${NAME}.p12 - found.  Did you mean:
    ls -l *.p12
fi

