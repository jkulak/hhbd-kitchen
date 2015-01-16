name             'jku-common'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures jku-common'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt', '~> 2.6.1'
depends 'user', '~> 0.3.0'
depends 'sudo', '~> 2.7.1'
depends 'git', '~> 4.1.0'
depends 'fail2ban', '~> 2.2.1'
depends 'magic_shell', '~> 1.0.0'
