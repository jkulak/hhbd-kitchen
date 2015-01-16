#
# Cookbook Name:: app-recipes-backend
# Recipe:: deploy
#
# Copyright 2015, WebAsCrazy.net <jakub.kulak@gmail.com>
#

# Additional packages

package 'php5-gd'
package 'php5-mysql'
package 'php5-common'
package "php5-memcache"

# Vhosts

# http://hhbd.pl.vmx/
web_app "000-hhbd.pl" do
  server_name "www.hhbd.pl.vmx"
  server_aliases ["hhbd.pl.vmx"]
  allow_override "All"
  docroot "#{node['apache']['docroot_dir']}/hhbd-app/public"
  # server_port "7777"
  cookbook 'apache2'
end

# http://s.hhbd.pl.vmx/
web_app "001-s.hhbd.pl.vmx" do
  server_name "s.hhbd.pl.vmx"
  allow_override "All"
  docroot "#{node['apache']['docroot_dir']}/s.hhbd.pl"
  cookbook 'apache2'
end

# Create log directory
directory "/var/log/#{node["app"]["hhbd-app"]["app_name"]}" do
    user node["deploy"]["user"]
    group node["deploy"]["group"]
    mode 00755
    action :create
    recursive true
end

# Copy configuration file
template "#{node['apache']['docroot_dir']}/#{node["app"]["hhbd-app"]["app_name"]}/application/configs/application.ini" do
    source "application.ini.erb"
    variables('config' => node['app']['hhbd-app']['config'])
end
