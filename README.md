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

