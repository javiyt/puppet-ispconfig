class ispconfig::webserver
{
	package
	{
		'nginx':
			require	=> Class['system'],
			ensure	=> latest,
	}

	service
	{
		'nginx':
			enable 		=> true,
			ensure 		=> running,
			hasrestart 	=> true,
			hasstatus 	=> true,
			require 		=> Package['nginx'],
	}

	class
	{
		'php::fpm::daemon':
			require => Package['nginx'],
	}

	php::ini
	{
		'/etc/php5/php.ini':
			display_errors			=> 'Off',
			memory_limit			=> '256M',
			expose_php				=> 'Off',
			upload_max_filesize		=> '30M',
			post_max_size			=> '30M',
			date_timezone			=> 'Europe/Madrid',
			require					=> Class['system'],
	}

	class
	{
		'php::cli':
			inifile	=> '/etc/php5/php.ini',
			require	=> Class['system'],
	}

	package
	{
		"memcached":
			ensure => latest,
	}

	php::module
	{
		['imagick', 'mysql', 'curl', 'gd', 'intl', 'imap', 'mcrypt', 'memcached', 'memcache', 'ming', 'ps', 'pspell', 'recode', 'snmp', 'sqlite', 'tidy', 'xmlrpc', 'xsl']:
	}

	package
	{
		"php-apc":
			ensure 	=> latest,
			require	=> Class['php::fpm::daemon']
	}
}