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

How to use it
================
In your default.pp file call the module using:
```puppet
class ispconfig
{
 	$mysql_root_passwd 		= 'test',
	$ssl_country				= 'TEST',
	$ssl_organization			= 'Test',
	$ssl_commonname			= 'Test',
	$ssl_state					= 'Test',
	$ssl_locality					= 'Test',
	$ssl_unit 					= 'Test',
	$ssl_altnames				= ['test@test.com'],
	$ssl_email					= 'test@test.com',
	$ssl_days					= 1,
	$ssl_password				= 'test',
	$jailkit_version				= '2.16',
	$php_date_timezone		= 'Test/Test',
	$php_memory_limit			= '64M',
	$php_upload_max_filesize	= '8M',
	$php_post_max_size		= '8M',
 }
 ```
