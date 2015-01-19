#
# Cookbook Name:: hhbd-content
# Recipe:: install
#
# Copyright 2015, WebAsCrazy.net <jakub.kulak@gmail.com>
#

# Additional packages

include_recipe "jku-common"

# http://s.hhbd.pl.vmx/
web_app "001-s.hhbd.pl.vmx" do
  server_name "s.hhbd.pl.vmx"
  allow_override "All"
  docroot "#{node['apache']['docroot_dir']}/s.hhbd.pl"
  cookbook 'apache2'
end

# Copy configuration file
template "#{node['apache']['docroot_dir']}/#{node["app"]["hhbd-app"]["app_name"]}/application/configs/application.ini" do
    source "application.ini.erb"
    variables('config' => node['app']['hhbd-app']['config'])
end
