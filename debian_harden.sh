#!/bin/bash
#
# Perform hardening operations for Debian distributions
#####################
# Author : Emir Ozer
# Creation Date: 11 Jan 2015
#####################
echo -n "I do not claim any responsibility for your use of this script."

sys_upgrades() {
    apt-get --yes --force-yes update
    apt-get --yes --force-yes upgrade
    apt-get --yes --force-yes autoremove
    apt-get --yes --force-yes autoclean
}

unattended_upg() {
    # IMPORTANT - Unattended upgrades may cause issues
    # But it is known that the benefits are far more than
    # downsides
    apt-get --yes --force-yes install unattended-upgrades
    dpkg-reconfigure -plow unattended-upgrades
    # This will create the file /etc/apt/apt.conf.d/20auto-upgrades
    # with the following contents:
    #############
    # APT::Periodic::Update-Package-Lists "1";
    # APT::Periodic::Unattended-Upgrade "1";
    #############
}

disable_root() {
    passwd -l root
    # for any reason if you need to re-enable it:
    # sudo passwd -l root
}

purge_nfs() {
    # This the standard network file sharing for Unix/Linux/BSD
    # style operating systems.
    # Unless you require to share data in this manner,
    # less layers = more sec
    apt-get --yes purge nfs-kernel-server nfs-common portmap rpcbind autofs
}

disable_compilers() {
    chmod 000 /usr/bin/cc
    chmod 000 /usr/bin/gcc
    # 755 to bring them back online
    # It is better to restrict access to them
    # unless you are working with a specific one
}

firewall() {
    apt-get --yes --force-yes install ufw
    ufw allow ssh
    ufw allow http
    ufw deny 23
    ufw default deny
    ufw enable
    }

harden_ssh_brute() {
    # Many attackers will try to use your SSH server to brute-force passwords.
    # This will only allow 6 connections every 30 seconds from the same IP address.
    ufw limit OpenSSH
}

harden_ssh(){
    sed -i 's/.*PermitRootLogin.*yes/PermitRootLogin no/g' /etc/ssh/ssh_config
}

logwatch_reporter() {
    apt-get --yes --force-yes install logwatch
    # make it run weekly
    cd
    cd ..
    cd ..
    mv /etc/cron.daily/00logwatch.dpkg-new /etc/cron.weekly/    
}

purge_at() {
    apt-get --yes purge at
    # less layers equals more security
}

disable_avahi() {
    sudo update-rc.d -f avahi-daemon remove
    # The Avahi daemon provides mDNS/DNS-SD discovery support
    # (Bonjour/Zeroconf) allowing applications to discover services on the network.
}

process_accounting() {
    # Linux process accounting keeps track of all sorts of details about which commands have been run on the server, who ran them, when, etc.
    apt-get --yes --force-yes install acct
    cd
    cd ..
    cd ..
    touch /var/log/wtmp
    # To show users' connect times, run ac. To show information about commands previously run by users, run sa. To see the last commands run, run lastcomm.
}

main() {
    sys_upgrades
    unattended_upg
    disable_root
    purge_nfs
    disable_compilers
    firewall
    harden_ssh_brute
    harden_ssh
    logwatch_reporter
    process_accounting
    purge_at
    disable_avahi
}

main "$@"
