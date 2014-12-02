#!/bin/bash

. /etc/init.d/functions

while read line; do
	./curl $line
done < ${1:-var/url.list} | tee /var/log/reductor.log
