#!/bin/bash

#create valid certificate for haproxy
cat autokey.pem autocert.pem > cert_comun.pem
#copy certificate to volume
rm -rf /certificados/*
cp *.pem /certificados/
cp /certificados/autokey.pem /certificados/server.key
cp /certificados/autocert.pem /certificados/server.crt
x11vnc -create -forever
