#!/bin/bash
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 02 -out server.crt
openssl pkcs12 -export -clcerts -in server.crt -inkey server.key -out server.p12
openssl pkcs12 -in server.p12 -out server.pem
openssl genrsa -out anotherclient.key 4096
openssl req -new -key anotherclient.key -out anotherclient.csr
openssl x509 -req -days 365 -in anotherclient.csr -CA ca.crt -CAkey ca.key -set_serial 02 -out anotherclient.crt
openssl pkcs12 -export -clcerts -in anotherclient.crt -inkey anotherclient.key -out anotherclient.p12
openssl pkcs12 -in anotherclient.p12 -out anotherclient.pem
