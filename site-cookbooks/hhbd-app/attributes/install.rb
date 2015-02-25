node.default["hhbd-app"]["url"] = "hhbd.pl.vmx"

node.default['hhbd-app']['config'] = {
    :emergency_log => "/var/log/#{default['hhbd-app']['url']}/emergency-hhbd.log",
    :debug_log => "/var/log/#{default['hhbd-app']['url']}/debug-hhbd.log",
    :base_url => "http://#{default["hhbd-app"]["url"]}/",
    :static_content_url => "http://s.#{default["hhbd-app"]["url"]}",
    :db => {
        :host => "127.0.0.1",
        :port => "3306",
        :username => "www",
        :password => "www",
        :name => "hhbd"
        },
    :mailserver => {
        :host => "localhost",
        :username => "www",
        :password => "www",
        :email => "vmx@hhbd.pl",
        :from => "Hhbd vmx"
        },
    :db_dump_file => "2015-01-21-hhbd.sql"
}

node.default['apache']['listen_ports'] = [8080]
