node.default["hhbd-app"]["url"] = "hhbd.pl.vmx"
node.default["hhbd-app"]["config"] = "hhbd.pl.vmx"

node.default['hhbd-app']['config'] = {
    :emergency_log => "/var/log/#{default['hhbd-app']['url']}/emergency-hhbd.log",
    :debug_log => "/var/log/#{default['hhbd-app']['url']}/debug-hhbd.log",
    :base_url => "http://#{default["hhbd-app"]["url"]}/",
    :db => {
        :host => "localhost",
        :port => "11221",
        :username => "www",
        :password => "www",
        :name => "hhbd",
        },
    :mailserver => {
        :host => "localhost",
        :username => "www",
        :password => "www",
        :email => "vmx@hhbd.pl",
        :from => "Hhbd vmx",
        }
}

