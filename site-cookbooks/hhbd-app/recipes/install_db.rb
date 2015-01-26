#
# Cookbook Name:: hhbd-app
# Recipe:: install_db
#
# Copyright 2015, WebAsCrazy.net <jakub.kulak@gmail.com>
#

# Additional packages

include_recipe "jku-mysql"

mysql_connection_info = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node["mysql"]["root_password"]
}

# Create databases and import data from a file

# Create a mysql database
mysql_database 'hhbd' do
  connection mysql_connection_info
  action :create
end

# Copy dump file
cookbook_file "/tmp/#{node["hhbd-app"]["config"]["db_dump_file"]}" do
    mode 00755
end

# import an sql dump from your app_root/data/dump.sql to the my_database database
execute 'import' do
  command "mysql -h #{node["hhbd-app"]["config"]["db"]["host"]} -u root -p\"#{node["mysql"]["root_password"]}\" #{node["hhbd-app"]["config"]["db"]["name"]} < /tmp/#{node["hhbd-app"]["config"]["db_dump_file"]}"
  action :run
end

# Create users

# Create a mysql user but grant no privileges
mysql_database_user 'www' do
  connection mysql_connection_info
  password   'www'
  action     :create
end

# Grant privilages
mysql_database_user 'www' do
  connection    mysql_connection_info
  password      'www'
  database_name node["hhbd-app"]["config"]["db"]["name"]
  host          '%'
  # privileges    [:create,:select,:update,:insert]
  privileges    [:select, :insert, :update, :delete, :create, :drop, :index, :alter]
  action        :grant
end

# Copy sql files

# Import sql files

# Query a database

execute 'import' do
  command "mysql -h #{node["hhbd-app"]["config"]["db"]["host"]} -u root -p\"#{node["mysql"]["root_password"]}\" -e 'flush privileges;'"
  action :run
end

# mysql_database 'flush the privileges' do
#   connection mysql_connection_info
#   sql        'flush privileges'
#   action     :query
# end
