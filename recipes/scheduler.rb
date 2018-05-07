bash "docker-cleanup" do
    user "root"
    returns [0, 1]
    code <<-EOH
    if docker ps | grep scheduler1;
    then
        docker stop scheduler1
        sleep 3
        docker rm scheduler1
    fi
    if docker ps -a | grep scheduler1;
    then
        docker rm scheduler1
    fi 
    if docker images | grep vouchdocker;
    then
        docker rmi $(sudo docker images | grep -m 1 vouchdocker | awk {'print $3'})
    fi
    EOH
end

Chef::Log.info('Docker cleaned')