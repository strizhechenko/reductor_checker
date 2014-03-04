#!/bin/bash

. /etc/init.d/functions

> failed
> blocked

while read line; do
	echo -n $line
	/usr/bin/curl --silent --connect-timeout 2 $line &>/dev/null
	if [ "$?" = 7 -o "$?" = 28 ]; then
		echo $line >> blocked 
		echo_success
	else
		echo $line >> failed
		echo_failure
	fi
	echo
done < ${1:-url.list}
