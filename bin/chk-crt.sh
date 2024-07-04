#!/bin/sh

# set -x

if [ $# -ne 1 ] ; then
    echo "Specify the name or domain to be tested"
    ls -l *.crt
    exit 1
fi

NAME=`echo $1 | sed 's/.crt//'`



if [ -f ${NAME}.crt ] ; then
    openssl x509 -in ${NAME}.crt -noout -text
else
    echo "No file - ${NAME}.crt - found.  Did you mean:
    ls -l *.crt
fi

