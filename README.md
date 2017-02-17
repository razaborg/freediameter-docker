# Presentation

The docker image build the code of freeDiameter directly from the official mercurial repo. By default all the freediameter extensions are enabled, and the program is directly installed to the root folder. 

The configuration file of diameter is directly embedded into the Docker image and located at: **/etc/freeDiameter/freeDiameter.conf**


## Environment variables

The following environment variables are used when you start a container. The **/root/script.sh** automatically replace them in the freeDiameter.conf config file.

 - TZ: Container timezone (default: Europe/Paris)
 - diameterID: hostname of the container (default: peer1)
 - domainName: network domain (default: localdomain)
 - params: all the params to give to the freeDiameterd program



## Quick usage

### Single server

    docker run -it -p 3868:3868 razaborg/freediameter

### Two peers

For example if you want to set-up a 2 peers diameter server connection. You can use the provided YML file with docker-compose:

    docker-compose -f compose-2peers.yml up -d

This will set up a docker network (called 'localdomain') with 2 peers (respectively 'peer1' and 'peer2' (I won the price of originality for this, yeah.)). 
The 2 containers will automatically generate their own specific configuration files, thanks to the script.sh starting script and their provided environment variables.


### Something else

Up to you bro! 
Use docker-compose and the config file of freeDiameter to do your magic ;-)
The script.sh file launched at container start-up will automatically configure the freeDiameter daemon to fit your needs.
