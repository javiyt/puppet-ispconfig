class ispconfig
(
 	$mysql_root_passwd 		= $ispconfig::params::mysql_root_passwd,
	$ssl_country				= '',
	$ssl_organization			= '',
	$ssl_commonname			= '',
	$ssl_state					= '',
	$ssl_locality					= '',
	$ssl_unit 					= '',
	$ssl_altnames				= [],
	$ssl_email					= '',
	$ssl_days					= $ispconfig::params::ssl_days,
	$ssl_password				= '',
	$jailkit_version				= $ispconfig::params::jailkit_version,
	$php_date_timezone		= $ispconfig::params::php_date_timezone,
	$php_memory_limit			= $ispconfig::params::php_memory_limit,
	$php_upload_max_filesize	= $ispconfig::params::upload_max_filesize,
	$php_post_max_size		= $ispconfig::params::php_post_max_size,
 )
inherits ispconfig::params
{
	Exec
	{
		path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
	}

	group
	{
		'puppet':
	    		ensure => present,
	}

	class
	{
		"ispconfig::ispconfig":
			require => [Class["ispconfig::system"], Class["ispconfig::fail2ban"], Class["ispconfig::jailkit"], Class["ispconfig::stats"], Class["ispconfig::dns"], Class["ispconfig::spamassassin"], Class["mail"]]
	}

	class
	{
		"ispconfig::fail2ban":
			require => Class["ispconfig::system"]
	}

	class
	{
		"ispconfig::jailkit":
			jailkit_version	=> $jailkit_version
			require 			=> Class["ispconfig::system"]
	}

	class
	{
		"ispconfig::stats":
			require => Class["ispconfig::system"]
	}

	class
	{
		"ispconfig::dns":
			require => Class["ispconfig::system"]
	}

	class
	{
		"ispconfig::ftp":
			require => Class["ispconfig::webserver"],
			ssl_country				=> $ssl_country,
			ssl_organization			=> $ssl_organization,
			ssl_commonname		=> $ssl_commonname,
			ssl_state				=> $ssl_state,
			ssl_locality				=> $ssl_locality,
			ssl_unit 				=> $ssl_unit,
			ssl_altnames			=> $ssl_altnames,
			ssl_email				=> $ssl_email,
			ssl_days				=> $ssl_days,
			ssl_password			=> $ssl_password,
	}

	class
	{
		"ispconfig::webserver":
			require 						=> Class["ispconfig::spamassassin"],
			php_date_timezone			=> $php_date_timezone,
			php_memory_limit			=> $php_memory_limit,
			php_upload_max_filesize	=> $upload_max_filesize,
			php_post_max_size			=> $php_post_max_size,
	}

	class
	{
		"ispconfig::spamassassin":
			require => Class["ispconfig::mail"]
	}

	class
	{
		"ispconfig::mail":
			require 				=> Class["ispconfig::system"],
			mysql_root_passwd	=> $mysql_root_passwd,
	}

	class
	{
		"ispconfig::system":
	}
}
