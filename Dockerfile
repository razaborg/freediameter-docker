FROM ubuntu:trusty
LABEL Maintainer "razaborg"
LABEL Description="An Ubuntu-based and simple Docker image of freeDiameter"

# Environement Variables:
# - TZ: Container timezone (default: Europe/Paris)
# - diameterID: hostname of the container (default: peer1)
# - domainName: network domain (default: localdomain)

# Updating the packages
RUN apt-get update
# Installing the freeDiameter dependencies
RUN sudo apt-get -y install mercurial cmake make gcc g++ bison flex libsctp-dev libgnutls-dev libgcrypt-dev libidn11-dev ssl-cert debhelper fakeroot libpq-dev libmysqlclient-dev libxml2-dev swig python-dev
# Downloading the code

WORKDIR /root 
RUN hg clone http://www.freediameter.net/hg/freeDiameter \
&& mkdir freeDiameter/fDBuild  

# Making the freeDiameter code
WORKDIR /root/freeDiameter/fDBuild 
RUN cmake -DCMAKE_BUILD_TYPE=Debug -DALL_EXTENSIONS=ON -DCMAKE_INSTALL_PREFIX='' ../ \
&& make \
&& make install

# Setting up the correct TZ
RUN ln -snf /usr/share/zoneinfo/${TZ:-Europe/Paris} /etc/localtime \
&& echo ${TZ:-Europe/Paris} > /etc/timezone

# Generating the TLS certificates
RUN mkdir -p /etc/ssl/certs/freeDiameter \
&& openssl req -new -batch -x509 -days 3650 -nodes -newkey rsa:1024 -out /etc/ssl/certs/freeDiameter/cert.pem -keyout /etc/ssl/certs/freeDiameter/privkey.pem -subj /CN=${diameterID:-peer1}.${domainName:-localdomain} \
&& openssl dhparam -dsaparam -out /etc/ssl/certs/freeDiameter/dh.pem 1024
COPY freeDiameter.conf /etc/freeDiameter/
ENTRYPOINT freeDiameterd -dd ${params}

EXPOSE 3868 5658
# RUN freeDiameterd

