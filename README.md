puppet-ispconfig
================

Install ISPConfig in a LEMP environment using puppet, based on http://www.howtoforge.com/perfect-server-debian-wheezy-nginx-bind-dovecot-ispconfig-3

Dependencies
================
The ISPConfig module has some dependencies you need to add to your puppet modules folder:
* apt: https://github.com/puppetlabs/puppetlabs-apt
* stdlib: https://github.com/puppetlabs/puppetlabs-stdlib.git
* ntp: https://github.com/puppetlabs/puppetlabs-ntp.git
* mysql: https://github.com/puppetlabs/puppetlabs-mysql.git
* php: https://github.com/thias/puppet-php
* pureftpd: https://github.com/saz/puppet-pureftpd
* openssl: https://github.com/camptocamp/puppet-openssl