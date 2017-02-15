# Presentation

The docker image build the code of freeDiameter directly from the official mercurial repo. By default all the freediameter extensions are enabled, and the program is directly installed to the root folder. 

The configuration file of diameter is directly embedded into the Docker image and located at: **/etc/freeDiameter/freeDiameter.conf**


## Dockerfile

The dockerfile permit to build the freeDiameter image using the following environement variables:

 - TZ: Container timezone (default: Europe/Paris)
 - diameterID: hostname of the container (default: peer1)
 - domainName: network domain (default: localdomain)
 - params: all the params to give to the freeDiameterd program



## Quick usage

### Single server

    docker run -it -p 3868:3868 razaborg/freediameter

### Two peers

To set-up a 2 peers diameter server connection, the easiest way is to use docker-compose:

    docker-compose -f docker-compose.yml up -d

This will set up a docker network (called 'localdomain') with 2 peers (respectively 'peer1' and 'peer2' (I won the price of originality for this, yeah.)). 
The 2 containers will load their respectives config files from a host folder (located in /srv/freeDiameter/peerN).


### Something else

Up to you bro! 
Use docker-compose and the config file of freeDiameter to do your magic ;-)
