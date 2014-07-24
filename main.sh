#!/bin/bash

. /etc/init.d/functions

> failed
> blocked

check() {
	echo -n $line
	# /usr/bin/curl --silent --connect-timeout 2 $line 2>/dev/null 1>/tmp/curl.$$
	wget -q -t 1 -T 2 $line 2>/dev/null 1>/tmp/curl.$$
	local retval=$?
	if [ "$retval" = '0' ]; then
	# if [ "$(</tmp/curl.$$)" != '302 Found. Site Block' -a "$retval" != '6' ]; then
		echo $retval: $line >> failed
		echo_failure
	else
		if [ "$retval" != '4' ]; then
			echo $retval: $line >> warning
			echo_warning
			echo
			return
		fi
		echo $line >> blocked
		echo_success
	fi
	echo
}

while read line; do
	[ "$(pgrep -P $$ | wc -l)" -gt '10' ] && wait
	check $line &
done < ${1:-url.list}
