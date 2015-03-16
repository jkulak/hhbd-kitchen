name "prod"
description "Production environment"

# define app domains
override_attributes "app-admin" => {
    "url" => "admin.new.hhbd.pl"
}, "app-xadmin" => {
    "url" => "xadmin.new.hhbd.pl"
}, "hhbd-app" => {
    "url" => "new.hhbd.pl"
}, "hhbd-content" => {
    "url" => "s.new.hhbd.pl"
}
