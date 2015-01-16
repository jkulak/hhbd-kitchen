#
# Cookbook Name:: jku-common
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'user::data_bag'
include_recipe 'sudo'
include_recipe 'git'
include_recipe 'fail2ban'
include_recipe 'magic_shell'

# Install network monitoring tools, TODO: select one that fits best
package 'bmon'
package 'slurm'
package 'tcptrack'
package 'iftop'
package 'nethogs'
package 'iptraf'

# Install system monitoring tool
package 'htop'

# Define ll alias
magic_shell_alias 'll' do
  command 'ls -la'
end

# Define www alias
magic_shell_alias 'www' do
  command 'cd /var/www && ll'
end

# Set env variable
magic_shell_environment 'TMPDIR' do
  value '/tmp'
end

# Upload custom motd
cookbook_file "/etc/update-motd.d/01-custom" do
    mode 00755
end

# Add id_rsa to archimedes - the deployment user
deploy_cred = Chef::EncryptedDataBagItem.load('keys', 'github')

if deploy_cred["deploy_key"]
  directory "/home/#{node[:deploy][:user]}/.ssh" do
    mode 00755
    action :create
    recursive true
    user node[:deploy][:user]
    group node[:deploy][:group]
  end

  ruby_block "write_key" do
    block do
      f = ::File.open("/home/#{node[:deploy][:user]}/.ssh/id_rsa", "w")
      f.print(deploy_cred["deploy_key"])
      f.close
    end
    not_if do ::File.exists?("/home/#{node[:deploy][:user]}/.ssh/id_rsa"); end
  end

  file "/home/#{node[:deploy][:user]}/.ssh/id_rsa" do
    mode '0600'
    user node[:deploy][:user]
    group node[:deploy][:group]
  end

  # Upload GitHub SSH wrapper - that allows archimedes - the deployment user - to use SSH key to interact with GitHub
  template "/home/#{node[:deploy][:user]}/.ssh/git-ssh-wrapper" do
    source "git-ssh-wrapper.erb"
    mode "0755"
    variables("deploy_dir" => "/home/#{node[:deploy][:user]}/.ssh/id_rsa")
  end
end
