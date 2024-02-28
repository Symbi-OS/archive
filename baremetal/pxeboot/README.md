# baremetal
Config for baremetal booting

Make sure tftp server is installed
Make sure dhcpd is installed and running.
Make sure xinetd is installed and running.
Avoid ip address *.0.
Take down firewalld if running.
Set liberal permissions on bzImage and initrd.
Make sure ips are configured on the same subnets.
Make sure vlan is actually connected.
This is currently incomplete because you need <tftpboot>/libutil.c32.

cp symbiote-initrd.cpio.gz baremetal/pxeboot/var/lib/tftpboot/served_files
ln -fs served_files/symbiote-initrd.cpio.gz initrd
cd baremetal/pxeboot
make disable_fw
make install_daemons
make connect_lan
make create_tftpboot
make replace_tftp
make replace_dhcpd.conf
make se_bools
make copy_pxeboot_files
make link_vanilla
make fix_perms
make enable_services
make start_services
