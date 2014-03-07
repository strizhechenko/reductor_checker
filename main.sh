#!/bin/bash

. /etc/init.d/functions

> failed
> blocked

while read line; do
	echo -n $line
	/usr/bin/curl --silent --connect-timeout 2 $line 2>/dev/null 1>/tmp/curl.$$
	retval=$?
	if [ "$(</tmp/curl.$$)" != '302 Found. Site Block' -a "$retval" != '6' ]; then
		echo $retval: $line>> failed
		echo_failure
	else
		echo $line >> blocked
		echo_success
	fi
	echo
done < ${1:-url.list}
