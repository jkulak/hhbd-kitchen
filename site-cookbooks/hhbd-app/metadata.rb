name             'hhbd-app'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures hhbd-app'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'jku-common'
depends 'jku-apache'
depends 'jku-mysql'
depends 'jku-memcached'
depends 'database', '~> 3.0.2'
