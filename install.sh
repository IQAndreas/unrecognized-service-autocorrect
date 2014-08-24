#!/bin/bash
# Installs a single 'unrecognized-service-autocorrect' script to '/usr/bin/'
# and creates links in '/etc/init.d/' from all the common service commands to aforementioned script

# This may need to be run as root in order to work
cp "unrecognized-service-autocorrect" "/usr/bin/unrecognized-service-autocorrect" || exit 1;

# Just in case permissions weren't preserved when the script was downloaded
chmod +x "/usr/bin/unrecognized-service-autocorrect" || exit 1;

commands=( start stop reload force-reload restart status )
for command in "${commands[@]}"; do
	# Will not overwrite the command if it already exists.
	# Who knows, maybe some day someone will create a service named 'restart'?
	if [ ! -e "$command" ]; then
		ln "/usr/bin/unrecognized-service-autocorrect" "/etc/init.d/$command"
	fi
done
