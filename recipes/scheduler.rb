execute "Pull scheduler" do 
    command "docker stop schedule1 && docker rm schedule1"
end