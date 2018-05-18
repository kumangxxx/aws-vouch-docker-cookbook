echo "-- deploying --"
docker stop schedule1 && docker rm schedule1
docker login -u vouchdocker -p 123dockerhub456
docker run -d --name schedule1 -p 6001:8001 -e ENV=_PRODUCTION -e SERVICE_NAME=scheduler_1 -e REDIS_HOST=scheduler-redis.2kk9v8.ng.0001.apse1.cache.amazonaws.com:6379 --restart always vouchdocker/schedule-service:0.2.14
echo "-- end deploy --"