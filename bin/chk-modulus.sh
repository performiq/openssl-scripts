#!/bin/sh

# set -x

if [ $# -ne 1 ] ; then
    echo "Specify the name or domain to be tested"
    ls -l *.csr *.crt *.key
    exit 1
fi

NAME=`echo $1 | sed 's/.csr//' | sed 's/.crt//' | sed 's/.key//'`

echo

if [ -f ${NAME}.csr ] ; then
    MD5_HASH=`openssl req -in ${NAME}.csr -noout -modulus | openssl md5`
    echo "${MD5_HASH} <- ${NAME}.csr"
else
    echo "No CSR file - ${NAME}.csr - found.  Did you mean:
    ls -l *.csr
fi

if [ -f ${NAME}.crt ] ; then
    MD5_HASH=`openssl x509 -in ${NAME}.crt -noout -modulus | openssl md5`
    echo "${MD5_HASH} <- ${NAME}.crt"
else
    echo "No CRT file - ${NAME}.crt - found.  Did you mean:
    ls -l *.crt
fi

if [ -f ${NAME}.key ] ; then
    if [ -f passphrase.txt ] ; then
        MD5_HASH=`openssl rsa -in ${NAME}.key -noout -modulus -passin file:passphrase.txt | openssl md5`
    else
        MD5_HASH=`openssl rsa -in ${NAME}.key -noout -modulus | openssl md5`
    fi
    echo "${MD5_HASH} <- ${NAME}.key"
else
    echo "No KEY file - ${NAME}.key - found.  Did you mean:
    ls -l *.key
fi

