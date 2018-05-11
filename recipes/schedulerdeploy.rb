cookbook_file "/tmp/deploydocker.sh" do
    source "deploydocker.sh"
    mode 0755
  end
  
  execute "run-deploy-script" do
    command "sh /tmp/deploydocker.sh || true"
  end