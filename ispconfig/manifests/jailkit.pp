# TODO: Remove the .deb file and directory after installation
class ispconfig::jailkit
{
	$jailkitVersion = '2.16'

	$tmp_path = '/tmp'
	$jailkitDir = "jailkit-$jailkitVersion"
	$jailkitFile = "jailkit-$jailkitVersion.tar.gz"
	$jailkitDeb = "$tmp_path/jailkit_$jailkitVersion-1_amd64.deb"

	$jailkitPackages = ['build-essential', 'autoconf', 'automake1.9', 'libtool', 'flex', 'bison', 'debhelper', 'binutils-gold', 'wget']
	package
	{
		$jailkitPackages:
			ensure => latest,
	}

	exec
	{
		'download_jailkit':
			command	=> "wget http://olivier.sessink.nl/jailkit/$jailkitFile",
			cwd			=> $tmp_path,
			require		=> Package[$jailkitPackages],
			creates		=> "$tmp_path/$jailkitFile",
			logoutput	=> false,
			onlyif		=> "dpkg -l jailkit | grep $jailkitVersion-1 | wc -l",
	}

	exec
	{
		'uncompress_jailkit':
			command	=> "tar zxf $jailkitFile",
			cwd			=> $tmp_path,
			require		=> Exec['download_jailkit'],
			creates		=> "$tmp_path/$jailkitDir",
			logoutput	=> false,
			onlyif		=> "dpkg -l jailkit | grep $jailkitVersion-1 | wc -l",
	}

	exec
	{
		'compile_jailkit':
			command	=> "$tmp_path/$jailkitDir/debian/rules binary",
			cwd			=> "$tmp_path/$jailkitDir/",
			require		=> Exec['uncompress_jailkit'],
			creates		=> $jailkitDeb,
			logoutput	=> false,
			onlyif		=> "dpkg -l jailkit | grep $jailkitVersion-1 | wc -l",
	}

	package
	{
		'jailkit':
			ensure		=> latest,
			source		=> $jailkitDeb,
			require		=> Exec['compile_jailkit'],
			provider	=> 'dpkg',
	}
}