class ispconfig::mail
(
	$mysql_root_passwd = $ispconfig::params::mysql_root_passwd
 )
inherits ispconfig::params
{
	class
	{
		'mysql::server':
			require 			=> Class["system"],
			config_hash		=> {
				root_password 	=>$mysql_root_passwd,
				bind_address 	=> '127.0.0.1',
			}
	}

	$packages = ["postfix", "openssl", "getmail4", "rkhunter", "binutils", "dovecot-imapd", "dovecot-pop3d", "dovecot-mysql", "dovecot-sieve"]

	package
	{
		$packages:
			ensure => latest,
			require => Class["mysql::server"],
	}

	package
	{
		["postfix-mysql", "postfix-doc"]:
			ensure => latest,
			require => Package[$packages],
	}

	file
	{
		"postfix_mastercf":
			ensure => file,
			source => 'puppet:///modules/ispconfig/postfix_master.cf',
			require => Package[$packages],
			name	=> '/etc/postfix/master.cf',
			owner	=> root,
			group 	=> root,
			notify	=> Service["postfix"],
	}

	service
	{
		"postfix":
		    	enable => true,
			ensure => running,
			require => [Package[$packages], File["postfix_mastercf"]],
	}

	package
	{
		'squirrelmail':
			ensure	=> latest,
			require	=> Package[["postfix-mysql", "postfix-doc"]],
	}
}