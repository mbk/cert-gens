#!/bin/bash
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 02 -out server.crt
openssl pkcs12 -export -clcerts -in server.crt -inkey server.key -out server.p12
openssl pkcs12 -in server.p12 -out server.pem
