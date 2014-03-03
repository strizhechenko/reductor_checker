#!/bin/bash

. /etc/init.d/functions

> failed
> blocked

while read line; do
	echo -n $line
	if [ "$(/usr/bin/curl --silent --connect-timeout 2 $line)" != '302 Found. Site Block' ]; then
		echo $line >> failed
		echo_failure
	else
		echo $line >> blocked
		echo_success
	fi
	echo
done < url.list
