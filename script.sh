#!/bin/bash


echo "# Setting up the correct TZ..."
ln -snf /usr/share/zoneinfo/${TZ:-Europe/Paris} /etc/localtime && echo ${TZ:-Europe/Paris} > /etc/timezone \
 || echo "Failed !"

echo "# Generating the TLS certificates..."
mkdir -p /etc/ssl/certs/freeDiameter \
&& openssl req -new -batch -x509 -days 3650 -nodes -newkey rsa:1024 -out /etc/ssl/certs/freeDiameter/cert.pem -keyout /etc/ssl/certs/freeDiameter/privkey.pem -subj /CN=${diameterID:-peer1}.${domainName:-localdomain} \
&& openssl dhparam -dsaparam -out /etc/ssl/certs/freeDiameter/dh.pem 1024 2>/dev/null >/dev/null\
 || echo "Failed !"

echo "# Configuring freeDiameter..."
sed -i.bak -Ee "s/\\\$diameterID/${diameterID:-peer1}/g" \
 -e "s/\\\$domainName/${domainName:-localdomain}/g" \
 -e "s/\\\$connectedToHost/${connectedToHost:-peer2.localdomain}/g" /etc/freeDiameter/freeDiameter.conf \
 || echo "Failed !"


echo "# Starting the daemon..."
/bin/freeDiameterd -dd ${params} || echo "Daemon Failed to start!"

