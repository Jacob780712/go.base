#!/bin/bash

echo "********************"
echo "This script generates TLS certificates for HTTPS network connections in development."
echo "******************** "
echo

# Use the cfssl toolkit to generate certs certificates,
# or you can use other tools to do so, and set the output location to . /certs.
cfssl gencert -initca ./certs/ca-csr.json | cfssljson -bare ./certs/ca
cfssl gencert -ca ./certs/ca.pem -ca-key=./certs/ca-key.pem -config ./certs/ca-config.json \
               -profile=server ./certs/server-csr.json | cfssljson -bare ./certs/server