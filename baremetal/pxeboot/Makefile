
# This clean target should remove all state we introduce
# Without disturbing what was already there
# i.e. we can't just wipe out the tftpboot dir if 
# it was already in use.

#LAN is connected to nic2, SERVER_LAN_DEV should correspond to the device that matches the mac address
#that HIL shows for nic2 on the given node

SERVER_LAN_DEV=eno2
SERVER_LAN_IP=192.168.19.33/24
SERVER_NODE=33
clean:

copy_pxeboot_files:
	cp -r var/lib/tftpboot/* /var/lib/tftpboot

fix_perms:
	chmod +x /var/lib/tftpboot/served_files/* /var/lib/tftpboot/*	

create_tftpboot:
	mkdir -p /var/lib/tftpboot

replace_tftp:
	cp etc/xinetd.d/tftp /etc/xinetd.d/tftp

#destructive replace dhcpd.conf
replace_dhcpd.conf:
	cp etc/dhcp/dhcpd$(SERVER_NODE).conf /etc/dhcp/dhcpd.conf

#install prereqs
install_daemons:
	dnf install xinetd tftp dhcp tftp-server

#firewall
disable_fw:
	systemctl stop firewalld

check_fw:
	systemctl status firewalld

#selinux
se_bools:
	setsebool -P tftp_anon_write 1
	setsebool -P tftp_home_dir 1

check_se:
	getsebool tftp_home_dir
	getsebool tftp_anon_write

start_services:
	systemctl start tftp.service
	systemctl start xinetd.service
	systemctl start dhcpd.service

restart_services:
	systemctl restart tftp.service
	systemctl restart xinetd.service
	systemctl restart dhcpd.service

enable_services:
	systemctl enable tftp.service
	systemctl enable xinetd.service
	systemctl enable dhcpd.service

service_status:
	systemctl status tftp.service
	systemctl status xinetd.service
	systemctl status dhcpd.service

connect_lan:
	sudo ip link set $(SERVER_LAN_DEV) down
	sudo ip addr flush $(SERVER_LAN_DEV)
	sudo ip addr add $(SERVER_LAN_IP) dev $(SERVER_LAN_DEV)
	sudo ip link set $(SERVER_LAN_DEV) up

#toggle source kernel Image by swinging symlink "vmlinuz" to point to one of the images in tftpboot/served_files
link_vanilla:
	ln -fs /var/lib/tftpboot/served_files/vanilla_vmlinuz /var/lib/tftpboot/vmlinuz

link_symbiote:
	ln -fs /var/lib/tftpboot/served_files/symbiote_vmlinuz /var/lib/tftpboot/vmlinuz

#debug tftp
#tftpd_log:
#	journalctl | grep tftp

