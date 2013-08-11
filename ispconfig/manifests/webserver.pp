class ispconfig::webserver
(
	$php_date_timezone		= $ispconfig::params::php_date_timezone,
	$php_memory_limit			= $ispconfig::params::php_memory_limit,
	$php_upload_max_filesize	= $ispconfig::params::upload_max_filesize,
	$php_post_max_size		= $ispconfig::params::php_post_max_size,
 )
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
			memory_limit			=> $php_memory_limit,
			expose_php				=> 'Off',
			upload_max_filesize		=> $php_upload_max_filesize,
			post_max_size			=> $php_post_max_size,
			date_timezone			=> $php_date_timezone,
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