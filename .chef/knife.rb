# cookbook_path    ["cookbooks", "site-cookbooks"]
cookbook_path    ["site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
encrypted_data_bag_secret "encrypted_data_bag_secret"

# knife[:berkshelf_path] = "cookbooks"
# knife[:secret_file] = '/Users/jkulak/.chef/encrypted_data_bag_secret'
# knife[:editor] = 'vi'

cookbook_copyright "Jakub Kułak"
cookbook_license "gplv3"
cookbook_email "jakub.kulak@gmail.com"
