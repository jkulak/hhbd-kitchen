name             'hhbd-apps'
maintainer       'Jakub Kułak'
maintainer_email 'jakub.kulak@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures hhbd-apps'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'jku-common', '~> 0.1.0'
depends 'jku-nodejs', '~> 0.1.0'
depends 'jku-php', '~> 0.1.0'
depends 'jku-apache', '~> 0.1.0'
depends 'jku-mysql', '~> 0.1.1'

depends 'apache2', '~> 3.1.0'
