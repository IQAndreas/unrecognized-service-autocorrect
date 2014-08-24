#!/bin/bash
# Installs a single 'unrecognized-service-autocorrect' script to '/usr/bin/'
# and creates links in '/etc/init.d/' from all the common service commands to aforementioned script

if [ "$#" -lt 1 ] || [ "$1" == '--warn' ]; then
	source_bin='unrecognized-service-autocorrect-warn'
elif [ "$1" == '--force' ]; then
	source_bin='unrecognized-service-autocorrect-force'
else
	echo "Unknown argument '$1'."
	echo "Valid parameters are '--warn' or '--force'".
	exit 1;
fi

target_bin='/usr/bin/unrecognized-service-autocorrect'

# This may need to be run as root in order to work
cp "$source_bin" "$target_bin" || exit 1;

# Just in case permissions weren't preserved when the script was downloaded
chmod +x "$target_bin" || exit 1;

commands=( start stop reload force-reload restart status )
for command in "${commands[@]}"; do
	# Will not overwrite the command if it already exists.
	# Who knows, maybe some day someone will create a service named 'restart'?
	if [ ! -e "$command" ]; then
		ln -s "$target_bin" "/etc/init.d/$command"
	fi
done
