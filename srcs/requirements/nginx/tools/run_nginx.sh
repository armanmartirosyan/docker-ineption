#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $KEYOUT_ -out $CERTS_ -subj "/C=AM/L=Yerevan/O=42/OU=student/CN=$DOMAIN_NAME"

cd /etc/nginx/sites-available/

sed -i "s#\$DOMAIN_NAME#$DOMAIN_NAME#g" nginx.conf
sed -i "s#\$CERTS_#$CERTS_#g" nginx.conf
sed -i "s#\$KEYOUT_#$KEYOUT_#g" nginx.conf

cat nginx.conf > default

rm -rf nginx.conf

nginx -g "daemon off;"