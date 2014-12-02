#!/bin/bash

. /etc/init.d/functions

mkdir -p var/log
while read line; do
	./curl $line
done < ${1:-var/url.list} | tee var/log/reductor.log
