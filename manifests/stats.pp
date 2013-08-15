class ispconfig::stats
{
	$statsPackages = ['vlogger', 'webalizer', 'awstats', 'geoip-database', 'libclass-dbi-mysql-perl']
	package
	{
		$statsPackages:
			ensure => latest,
	}

	file
	{
		"/etc/cron.d/awstats":
			ensure 	=> file,
			source	=> 'puppet:///modules/ispconfig/awstats',
			require 	=>Package[$statsPackages],
			owner	=> root,
			group 	=> root,
	}
}