class ispconfig::dns
{
	package
	{
		['bind9', 'dnsutils']:
			ensure => latest,
	}
}