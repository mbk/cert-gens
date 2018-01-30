#!/bin/bash
if [ -z "$1" ]
  then
    printf "No certifcate name argument supplied, exiting"
    exit
fi
#mk cert output dir, if needed
mkdir -p cert-output
cd cert-output

printf "\n generating another client cert under the same CA in all formats \n"
openssl genrsa -out $1.key 4096
openssl req -new -key $1.key -out $1.csr
openssl x509 -req -days 365 -in $1.csr -CA ca.crt -CAkey ca.key -set_serial 02 -out $1.crt
openssl pkcs12 -export -clcerts -in $1.crt -inkey $1.key -out $1.p12
openssl pkcs12 -in $1.p12 -out $1.pem
