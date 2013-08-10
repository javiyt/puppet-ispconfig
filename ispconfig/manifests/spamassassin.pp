class ispconfig::spamassassin
{
	$spamPackages = ["amavisd-new", "spamassassin", "clamav", "clamav-daemon", "zoo", "unzip", "bzip2", "arj", "nomarch", "lzop", "cabextract", "apt-listchanges", "libnet-ldap-perl", "libauthen-sasl-perl", "clamav-docs", "daemon", "libio-string-perl", "libio-socket-ssl-perl", "libnet-ident-perl", "zip", "libnet-dns-perl"]

	package
	{
		$spamPackages:
			ensure	=> latest,
	}

	service
	{
		"spamassassin":
			enable	=> false,
			ensure	=> stopped,
			require	=> Package[$spamPackages],
	}
}