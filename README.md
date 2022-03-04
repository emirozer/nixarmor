![Screenshot](https://raw.github.com/emirozer/nixarmor/master/docs/nixarmor.png)
=======================
## Linux Hardening Automation Project

![travis](https://travis-ci.org/emirozer/nixarmor.svg?branch=master)

*This program comes with ABSOLUTELY NO WARRANTY!*

*Be Advised, do NOT use in production environments!*

Wikipedia's description for Hardening:

> In [computer security][1], hardening is usually the process of securing a system by 
> reducing its [surface of vulnerability][2], which is larger when a system performs more functions; 
> in principle a single-function system is more secure than a multipurpose one.
> Reducing available ways of attack typically includes changing default passwords, 
> the removal of unnecessary software, unnecessary [usernames][3] or [logins][4], 
> and the disabling or removal of unnecessary [services][5].

[1]: https://en.wikipedia.org/wiki/Computer_security
[2]: https://en.wikipedia.org/wiki/Attack_surface
[3]: https://en.wikipedia.org/wiki/User_name
[4]: https://en.wikipedia.org/wiki/Logging_(computer_security)
[5]: http://en.wikipedia.org/wiki/Hardening_%28computing%29


## USAGE

Clone the repository.

	git clone https://github.com/emirozer/nixarmor.git

Run the related automation script based on your distribution.

**OR**

You can try the environment via using vagrant.
Go to the /vagrant/.. dir and pick the distro you are interested in.

    vagrant up

*I am assuming you have* [vagrant](https://www.vagrantup.com) *on your system packages for this task.*

### CHKROOTKIT & Cron Job

Chkrootkit is installed for ubuntu/debian/fedora and ran once.

For **centOS**, **yum** won't serve this [package](http://www.chkrootkit.org/) so you have to get it manually.

It is in your best interest to run chkrootkit daily.
Here are some basic universal instructions:

	vi /etc/cron.daily/chkrootkit.sh

	#!/bin/bash
	cd /your_installpath/chkrootkit-0.42b/
	./chkrootkit | mail -s “Daily chkrootkit from Servername” admin@youremail.com


Note

1. Replace ‘your_installpath’ with the actual path to where you unpacked Chkrootkit.

2. Change ‘Servername’ to the server which you are running.

3. Change ‘admin@youremail.com’ to your actual email address where the script will mail you.


Save the file.

Change the file permissions

	chmod 755 /etc/cron.daily/chkrootkit.sh

*Small note about unattanded updates:* It is a good idea if and only if you compose your own black list..Meaning put everything that you find upgrading without supervision risky. http://askubuntu.com/questions/193773/can-i-configure-unattended-upgrades-to-not-upgrade-packages-that-require-a-reboo
