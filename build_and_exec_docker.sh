#!/bin/bash
#generar nombre aleatorio to lower case
randomName=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 4 | tr '[:upper:]' '[:lower:]' | head -n 1)
dockerName="challenge-${randomName}"
echo "==> Info: Building docker image"
docker build -t challenge:latest .
#
#docker run --name challenge -d 
# -it challenge:latest

#docker run ephemeral run whith name challenge whith environment variables
echo "==> Info: Running docker container with name ${dockerName}"
docker run --name ${dockerName} -d -e AWS_ACCESS_KEY_ID="${1}" -e AWS_SECRET_ACCESS_KEY="${2}" challenge:latest 
#/bin/bash -c /challenge.sh
echo "==> Info: Waiting for docker container to finish"
echo "==> Info: Docker container logs"
docker logs -f ${dockerName}
echo "==> Info: Stopping and removing docker container"

#una ves terminado el docker si se quiere ejecutar comando a mano dentro del container ejecutar el siguiente comando
#docker commit 373973d6bc53 challenge--debug
# docker run -ti --entrypoint=sh  challenge--debug