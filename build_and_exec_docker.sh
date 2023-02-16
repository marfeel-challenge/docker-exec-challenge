#!/bin/bash
echo "==> Info: Building docker image"
docker build -t challenge:latest .
#
#docker run --name challenge -d 
# -it challenge:latest

#docker run ephemeral run whith name challenge whith environment variables
echo "==> Info: Running docker image"
docker run --name challenge -d -e AWS_ACCESS_KEY_ID="${1}" -e AWS_SECRET_ACCESS_KEY="${2}" challenge:latest /bin/bash -c /challenge.sh
echo "==> Info: Waiting for docker container to finish"
echo "==> Info: Docker container logs"
docker logs -f challenge
echo "==> Info: Stopping and removing docker container"
docker stop challenge
docker rm challenge
