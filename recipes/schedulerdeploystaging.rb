cookbook_file "/tmp/deploydockerstaging.sh" do
    source "deploydockerstaging.sh"
    mode 0755
end
  
execute "run-deploy-script" do
  command "sh /tmp/deploydockerstaging.sh || true"
end
