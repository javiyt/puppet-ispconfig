class ispconfig
(
 	$mysql_root_passwd 	= $ispconfig::params::mysql_root_passwd,
	$ssl_country			= '',
	$ssl_organization		= '',
	$ssl_commonname		= '',
	$ssl_state				= '',
	$ssl_locality				= '',
	$ssl_unit 				= '',
	$ssl_altnames			= [],
	$ssl_email				= '',
	$ssl_days				= $ispconfig::params::ssl_days,
	$ssl_password			= ''
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
			require => Class["ispconfig::system"]
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
			require => Class["ispconfig::spamassassin"]
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
