Chef::Log.info("***************** Deploying ***************")
bash "docker-cleanup" do
    user "root"
    returns [0, 1, 2, 125]
    code <<-EOH
        docker stop schedule1 && docker rm schedule1
    EOH
end

bash "docker-rmi" do
    user "root"
    returns [0, 1, 2, 125]
    code <<-EOH
        docker rmi $(sudo docker images | grep -m 1 vouchdocker | awk {'print $3'})
    EOH
end

Chef::Log.info('*********** Docker cleaned, pulling and running ****************')

bash "docker-login" do
    user "root"
    returns [0, 1, 2, 125]
    code <<-EOH
        docker login -u vouchdocker -p 123dockerhub456
    EOH
end

bash "docker-run" do
    user "root"
    returns [0, 1, 2, 125]
    code <<-EOH
        docker run --name schedule1 -p 6001:8001 -e ENV=_PRODUCTION -e SERVICE_NAME=scheduler_1 -e REDIS_HOST=scheduler-redis.2kk9v8.ng.0001.apse1.cache.amazonaws.com:6379 --restart always vouchdocker/schedule-service:0.2.13
    EOH
end

Chef::Log.info('********** All set! ***************')