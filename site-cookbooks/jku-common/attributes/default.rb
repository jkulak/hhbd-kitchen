# Add more users per project on top on regular bauer-provisioning cookbook
node.default['users'].push('jkulak', 'archimedes')
node.default['authorization']['sudo']['users'].push('jkulak', 'archimedes')

node.default['deploy']['user'] = 'archimedes'
node.default['deploy']['group'] = 'archimedes'
