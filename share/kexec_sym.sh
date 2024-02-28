kexec -l /boot/vmlinuz-5.8.0-symbiote+ --append=ro rootflags=subvol=root intel_pstate=disable mitigations=off --initrd=/boot/initramfs-5.8.0-symbiote+.img
kexec -e
