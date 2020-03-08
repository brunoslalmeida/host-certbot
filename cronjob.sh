#!/bin/sh
cwd=$(pwd)

(crontab -l 2>/dev/null; echo "0 23 * * * sh $cwd/renew.sh") | crontab -
