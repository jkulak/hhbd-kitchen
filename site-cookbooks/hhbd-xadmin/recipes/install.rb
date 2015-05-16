#
# Cookbook Name:: hhbd-xadmin
# Recipe:: install
#
# Copyright 2015, WebAsCrazy.net <jakub.kulak@gmail.com>
#

# Create initial release repository
directory "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/initial" do
    mode 00755
    action :create
    recursive true
    user node[:deploy][:user]
    group node[:deploy][:group]
end

# Empty directory for /releases/previous symlink
directory "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/preinitial" do
    mode 00755
    action :create
    recursive true
    user node[:deploy][:user]
    group node[:deploy][:group]
end

# Create current symlinks
link "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/current" do
    to "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/initial"
    user node[:deploy][:user]
    group node[:deploy][:group]
    not_if { File.symlink?("#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/current") }
end

# Create previous symlink
link "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/previous" do
    to "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/preinitial"
    user node[:deploy][:user]
    group node[:deploy][:group]
    not_if { File.symlink?("#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/previous") }
end

# Create current->www symlink
link "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/www" do
    to "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/releases/current"
    user node[:deploy][:user]
    group node[:deploy][:group]
    not_if { File.symlink?("#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/www") }
end

# create apache vhost
web_app "020-#{node["app-xadmin"]["url"]}" do
    server_name "#{node["app-xadmin"]["url"]}"
    server_aliases ["www.#{node["app-xadmin"]["url"]}"]
    allow_override "All"
    docroot "#{node['apache']['docroot_dir']}/#{node["app-xadmin"]["url"]}/www"
    cookbook "apache2"
end

# copy nginx configuration
template "/etc/nginx/sites-available/#{node["app-xadmin"]["url"]}" do
    source "xadmin.hhbd.pl.erb"
    mode "0644"
    variables('server_name' => node["app-xadmin"]["url"])
end

# enable nginx configuration
nginx_site node["app-xadmin"]["url"] do
    enable true
end
