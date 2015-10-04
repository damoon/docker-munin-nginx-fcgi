#!/bin/bash
touch /var/log/munin/munin-cgi-graph.log
touch /var/log/munin/munin-cgi-html.log
chown munin. /var/log/munin/munin-cgi-graph.log
chown munin. /var/log/munin/munin-cgi-html.log

chown munin. /var/lib/munin/

su - munin --shell=/bin/bash -c /usr/bin/munin-cron
spawn-fcgi -s /var/run/munin/fastcgi-graph.sock -U www-data -u munin -g munin /usr/lib/munin/cgi/munin-cgi-graph
spawn-fcgi -s /var/run/munin/fastcgi-html.sock  -U www-data -u munin -g munin /usr/lib/munin/cgi/munin-cgi-html

/usr/sbin/rsyslogd
/usr/sbin/cron
service nginx start

# show logs
echo 'Tailing /var/log/syslog and /var/log/munin/*'
tail -f /var/log/syslog /var/log/munin/*
