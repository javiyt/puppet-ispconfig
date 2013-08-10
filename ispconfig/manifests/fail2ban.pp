class ispconfig::fail2ban
{
	package
	{
		'fail2ban':
			ensure => latest,
	}

	service
	{
		'fail2ban':
			enable => true,
			ensure => running,
			require => Package['fail2ban'],
	}

	file
	{
		'/etc/fail2ban/jail.local':
			ensure 	=> present,
			content	=> 'puppet:///modules/ispconfig/failban_jain.local',
			require 	=> Package['fail2ban'],
			notify	=> Service['fail2ban'],
			owner	=> root,
			group 	=> root,
	}

	file
	{
		'/etc/fail2ban/filter.d/pureftpd.conf':
			ensure 	=> present,
			content	=> 'puppet:///modules/ispconfig/failban_pureftpd.conf',
			require 	=> Package['fail2ban'],
			notify	=> Service['fail2ban'],
			owner	=> root,
			group 	=> root,
	}

	file
	{
		'/etc/fail2ban/filter.d/dovecot-pop3imap.conf':
			ensure 	=> present,
			content	=> 'puppet:///modules/ispconfig/failban_dovecot.conf',
			require 	=> Package['fail2ban'],
			notify	=> Service['fail2ban'],
			owner	=> root,
			group 	=> root,
	}
}