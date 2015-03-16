#
# Cookbook Name:: hhbd-content
# Recipe:: install
#
# Copyright 2015, WebAsCrazy.net <jakub.kulak@gmail.com>
#

# Additional packages
include_recipe "jku-common"
include_recipe "jku-nginx"

# Create initial release repository
directory "#{node['apache']['docroot_dir']}/#{node["hhbd-content"]["url"]}/www" do
    mode 00755
    action :create
    recursive true
    user node[:deploy][:user]
    group node[:deploy][:group]
end

template "/etc/nginx/sites-available/#{node["hhbd-content"]["url"]}" do
    source "s.hhbd.pl.erb"
    mode "0644"
    variables('server_name' => node["hhbd-content"]["url"])
end

nginx_site node["hhbd-content"]["url"] do
    enable true
end
