#
# Cookbook Name:: hhbd-admin
# Recipe:: install
#
# Copyright 2015, WebAsCrazy.net <jakub.kulak@gmail.com>
#

# Create initial release repository
directory "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/releases/initial" do
    mode 00755
    action :create
    recursive true
    user node[:deploy][:user]
    group node[:deploy][:group]
end

# Empty directory for /releases/previous symlink
directory "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/releases/preinitial" do
    mode 00755
    action :create
    recursive true
    user node[:deploy][:user]
    group node[:deploy][:group]
end

# Create current symlinks
link "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/releases/current" do
    to "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/releases/initial"
    user node[:deploy][:user]
    group node[:deploy][:group]
    not_if { File.symlink?("#{node['apache']['docroot_dir']}/#{node["hhbd-admin"]["url"]}/releases/current") }
end

# Create previous symlink
link "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/releases/previous" do
    to "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/releases/preinitial"
    user node[:deploy][:user]
    group node[:deploy][:group]
    not_if { File.symlink?("#{node['apache']['docroot_dir']}/#{node["hhbd-admin"]["url"]}/releases/previous") }
end

# Create current->www symlink
link "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/www" do
    to "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/releases/current"
    user node[:deploy][:user]
    group node[:deploy][:group]
    not_if { File.symlink?("#{node['apache']['docroot_dir']}/#{node["hhbd-admin"]["url"]}/www") }
end

# create apache vhost
web_app "010-#{node["app-admin"]["url"]}" do
    server_name "#{node["app-admin"]["url"]}"
    server_aliases ["www.#{node["app-admin"]["url"]}"]
    allow_override "All"
    docroot "#{node['apache']['docroot_dir']}/#{node["app-admin"]["url"]}/www"
    cookbook "apache2"
end

# copy nginx configuration
template "/etc/nginx/sites-available/#{node["app-admin"]["url"]}" do
    source "admin.hhbd.pl.erb"
    mode "0644"
    variables('server_name' => node["app-admin"]["url"])
end

# enable nginx configuration
nginx_site node["app-admin"]["url"] do
    enable true
end
