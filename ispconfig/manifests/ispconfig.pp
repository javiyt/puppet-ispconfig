class ispconfig::ispconfig
{
	$tmp_path = '/tmp'

	service
	{
		'apache2':
			enable => false,
			ensure => stopped,
	}

	exec
	{
		'download_ispconfig':
			command	=> 'wget http://www.ispconfig.org/downloads/ISPConfig-3-stable.tar.gz',
			cwd			=> $tmp_path,
			require		=> Package['wget'],
			creates		=> "$tmp_path/ISPConfig-3-stable.tar.gz",
			logoutput	=> false,
			onlyif		=> 'ls /usr/local/bin/ | grep ispconfig_update | wc -l',
	}

	exec
	{
		'uncompress_ispconfig':
			command	=> 'tar xfz ISPConfig-3-stable.tar.gz',
			cwd			=> $tmp_path,
			require		=> Exec['download_ispconfig'],
			creates		=> "$tmp_path/ispconfig3_install",
			logoutput	=> false,
			notify		=> Service['nginx'],
			onlyif		=> 'ls /usr/local/bin/ | grep ispconfig_update | wc -l',
	}
}