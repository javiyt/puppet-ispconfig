class ispconfig::ftp
(
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
{
	class
	{
		'pureftpd':
			virtualchroot 	=> true,
			auth_type 		=> mysql,
			require			=> Class['system'],
	}

	package
	{
		['quota', 'quotatool']:
			ensure => latest,
	}

	file
	{
		'/etc/pure-ftpd/conf/TLS':
			ensure 	=> file,
			require	=> Class['pureftpd'],
			content	=> '1',
	}

	file
	{
		'/etc/ssl/private/':
			ensure	=> directory,
			require	=> Class['pureftpd'],
	}

	openssl::certificate::x509
	{
		'pure-ftpd.pem':
			ensure				=> present,
			country				=> $ssl_country,
			organization		=> $ssl_organization,
			commonname		=> $ssl_commonname,
			state				=> $ssl_state,
			locality				=> $ssl_locality,
			unit 				=> $ssl_unit,
			altnames			=> $ssl_altnames,
			email				=> $ssl_email,
			days				=> $ssl_days,
			base_dir			=> '/etc/ssl/private',
			owner				=> 'root',
			password			=> $ssl_password,
			force				=> true,
			require				=> File['/etc/ssl/private/'],
			notify				=> Concat['/etc/ssl/private/pure-ftpd.pem']
	}

	$pempath = '/etc/ssl/private/pure-ftpd.pem'
	concat { 
		$pempath:
			owner => 'root',
			group => 'root',
			mode => '0600',
			notify => Service['pure-ftpd-mysql']
	}

	concat::fragment{ 
		'privatekey':
			target => $pempath,
			source => '/etc/ssl/private/pure-ftpd.pem.key',
			order => '1'
	}

	concat::fragment{ 
		'certificate':
			target => $pempath,
			source => '/etc/ssl/private/pure-ftpd.pem.crt',
			order => '2',
	}
}
