echo "-- deploying docker --"
docker stop $DOCKER_NAME && docker rm $DOCKER_NAME
docker rmi $(docker images -q)
docker run -d --name $DOCKER_NAME -p $HOST_PORT:$DOCKER_PORT --env-file /usr/local/bin/environment.env --restart always $DOCKER_CONTAINER
echo "-- end deploy --"