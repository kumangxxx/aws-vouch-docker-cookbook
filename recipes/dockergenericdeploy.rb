Chef::Log.info("Setting environment variables")
Chef::Log.info("Node #{ node } | deploy #{ node[:deploy] }")

if node[:deploy] === nil

	Chef::Log.info("No deployment..")

elsif

	Chef::Log.info("Setting environment variables for current process  #{ node[:deploy] }")
	node[:deploy].each do |depname, depval|
		depval[:environment_variables].each do |name, value|
			ENV["#{name}"] = "#{value}"
		end
	end

	# node[:deploy]['vouch_server'][:environment_variables].each do |name, value|
		
	# end

	Chef::Log.info("Creating shell file to export variables")
	template "/usr/local/bin/environment.sh" do
		source "environment.sh.erb"
		mode "0755"
		owner "root"
		group "root"
	end

	Chef::Log.info("Creating env file")
	template "/usr/local/bin/environment.env" do
		source "environment.env.erb"
		mode "0755"
		owner "root"
		group "root"
	end


	Chef::Log.info("Exporting variables for every new created process")
	execute "/usr/local/bin/environment.sh" do
		user "root"
		action :run
	end

	Chef::Log.info("Running Docker")
	cookbook_file "/tmp/deploydockergeneric.sh" do
	source "deploydockergeneric.sh"
	mode 0755
	end

	execute "complete deploy" do
	command "sh /tmp/deploydockergeneric.sh"
	end

end