name "aws-vouch-docker-cookbook"

source_url 'https://github.com/NOX73/chef-golang' if respond_to?(:source_url)
issues_url 'https://github.com/NOX73/chef-golang/issues' if respond_to?(:issues_url)

depends "apt"
depends "docker"
