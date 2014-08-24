Do you, like me, frequently flip the arguments of the `service` command like this?

```
$ sudo service restart apache2
restart: unrecognized service
```

This tiny "library" (less than 1kb) gives you a bit more helpful error message:

```
$ sudo service restart apache2
restart: unrecognized service
Did you mean 'service apache2 restart'?
```

### Installation

To add this capability to your system, simply run `install.sh` (which will likely require elevated privelages). 

It will add the shell script `/usr/bin/unrecognized-service-autocorrect`, and soft links that point there from the following locations:

```
 * /etc/init.d/start
 * /etc/init.d/stop
 * /etc/init.d/reload
 * /etc/init.d/force-reload
 * /etc/init.d/restart
 * /etc/init.d/status
```

The script will not overwrite any existing services found in that directory (who knows, maybe there will one day be a service out there named `restart`?)

The installation script (as well as any other files found in this repository) can then safely be removed from your system.
