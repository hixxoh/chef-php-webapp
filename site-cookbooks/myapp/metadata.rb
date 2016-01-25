name             'myapp'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'hixxoh@gmail.com'
license          'All rights reserved'
description      'Installs/Configures myapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'nginx'
depends 'mysql'
depends 'mysql2_chef_gem'
depends 'database'
depends 'php-fpm'

