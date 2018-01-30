#!/bin/bash
if [ -z "$1" ]
  then
    printf "No certifcate name argument supplied, exiting"
    exit
fi
#mk cert output dir, if needed
mkdir -p cert-output
cd cert-output
#Create CA
printf "\n\n CREATING CA \n"
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 365 -key ca.key -out ca.crt
#create client key in all possible format
printf "\n CREATING client certs under CA in various formats. Be ready to
type some passwords per format. \n"
openssl genrsa -out $1.key 4096
openssl req -new -key $1.key -out $1.csr
openssl x509 -req -days 365 -in $1.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out $1.crt
openssl pkcs12 -export -clcerts -in $1.crt -inkey $1.key -out $1.p12
openssl pkcs12 -in $1.p12 -out $1.pem
