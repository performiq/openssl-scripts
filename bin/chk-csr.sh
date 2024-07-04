#!/bin/sh

# set -x

if [ $# -ne 1 ] ; then
    echo "Specify the name or domain to be tested"
    ls -l *.csr
    exit 1
fi

NAME=`echo $1 | sed 's/.csr//'`

if [ -f ${NAME}.csr ] ; then
    openssl req  -in ${NAME}.csr -text -noout
else
    echo "No file - ${NAME}.csr - found.  Did you mean:
    ls -l *.csr
fi

