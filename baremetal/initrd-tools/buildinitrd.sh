#!/bin/bash
# This file based in part on the mkinitramfs script for the LFS LiveCD
# written by Alexander E. Patrakov and Jeremy Huntwork.

copy()
{
  local file

  if [ "$2" = "lib" ]; then
    file=$(PATH=/usr/lib:/usr/lib64 type -p $1)
  else
    file=$(type -p $1)
  fi

  if [ -n "$file" ] ; then
    cp $file $WDIR/$file	
  else
    echo "Missing required file: $1 for directory $2"
    # rm -rf $WDIR
    # exit 1
  fi
}

printf "Creating initramfs structure ... "

binfiles="cat cp dd ls mkdir mknod mount bash "
binfiles="$binfiles umount sed sleep ln rm uname grep hostname"
binfiles="$binfiles readlink basename chmod df dmesg du file"
binfiles="$binfiles kmod less vi lsblk more mv perf ping"
binfiles="$binfiles ps touch id env nohup nproc pgrep pkill"
binfiles="$binfiles ssh scp sync tail taskset tee timeout"
binfiles="$binfiles tshark wc cut seq tput top stat awk sed"
binfiles="$binfiles grep echo dmesg cut htop gdb dumpcap"

sbinfiles="ip halt ifconfig dropbear rdmsr wrmsr lspci ethtool sshd"

unsorted=$(mktemp /tmp/unsorted.XXXXXXXXXX)

nss="libnss_systemd.so.2 libnssckbi.so libnss_sss.so.2 libnss_compat.so.2" 
nss="$nss libnss_files-2.29.so libnss_compat-2.29.so libnss_myhostname.so.2"
nss="$nss libnssdbm3.chk libnss_files.so.2 libnss_mymachines.so.2 libnssdbm3.so"
nss="$nss libnssutil3.so libnss3.so libnsssysinit.so libnss_resolve.so.2"
nss="$nss libnss_dns.so.2 libnss_dns-2.29.so"
for f in $nss ; do
  echo $f >> $unsorted
done

INITIN=$2/init

# Create a temporary working directory
WDIR=$1

# Create base directory structure
mkdir -p $WDIR/{dev,etc/dropbear,run,sys,proc,usr/{bin,lib,lib64,sbin},var/run}
ln -s usr/bin  $WDIR/bin
ln -s usr/lib  $WDIR/lib
ln -s usr/sbin $WDIR/sbin
ln -s lib      $WDIR/lib64

# Create necessary device nodes
mknod -m 640 $WDIR/dev/tty0    c 4 0
mknod -m 640 $WDIR/dev/tty1    c 4 1
mknod -m 640 $WDIR/dev/tty     c 5 0
mknod -m 640 $WDIR/dev/console c 5 1
mknod -m 644 $WDIR/dev/ptmx    c 5 2
mknod -m 664 $WDIR/dev/null    c 1 3
mknod -m 664 $WDIR/dev/zero    c 1 5
mknod -m 664 $WDIR/dev/random  c 1 8
mknod -m 664 $WDIR/dev/urandom c 1 9
mknod -m 664 $WDIR/dev/loop0   b 7 0
mknod -m 664 $WDIR/dev/loop1   b 7 1
mkdir -m 755 $WDIR/dev/pts
mknod -m 600 $WDIR/dev/pts/0   c 136 0
mknod -m 000 $WDIR/dev/pts/ptmx c 5 2


# Install the init file
install -m0755 $INITIN $WDIR/init

# Install basic binaries
for f in $binfiles ; do
  ldd /usr/bin/$f | sed "s/\t//" | cut -d " " -f1 >> $unsorted
  copy /usr/bin/$f bin
done

ln -s bash $WDIR/usr/bin/sh

for f in $sbinfiles ; do
  ldd /usr/sbin/$f | sed "s/\t//" | cut -d " " -f1 >> $unsorted
  copy $f sbin
done

# Install libraries
sort $unsorted | uniq | while read library ; do
# linux-vdso and linux-gate are pseudo libraries and do not correspond to a file
# libsystemd-shared is in /lib/systemd, so it is not found by copy, and
# it is copied below anyway
  if [[ "$library" == linux-vdso.so.1 ]] ||
     [[ "$library" == linux-gate.so.1 ]] ||
     [[ "$library" == libsystemd-shared* ]]; then
    continue
  fi

  copy $library lib
done

firmware="bnx2 bnx2x bnx2x-e1-4.8.53.0.fw bnx2x-e1-5.2.13.0.fw "
firmware="$firmware bnx2x-e1-5.2.7.0.fw bnx2x-e1h-4.8.53.0.fw"
firmware="$firmware bnx2x-e1h-5.2.13.0.fw bnx2x-e1h-5.2.7.0.fw"
firmware="$firmware brcm intel"

mkdir -p $WDIR/lib/firmware
for f in $firmware ; do
  cp -R /lib/firmware/$f $WDIR/lib/firmware/$f
done

mkdir -p $WDIR/usr/share

cp -r /usr/share/crypto-policies $WDIR/usr/share
cp -r /usr/share/terminfo $WDIR/usr/share

conf="aliases bashrc bash_completion.d group hosts passwd profile nsswitch.conf"
conf="$conf shells shadow ssh crypto-policies sysconfig"
for f in $conf ; do
  cp -r /etc/$f $WDIR/etc/$f
done

chmod -R go-rwx $WDIR/etc/ssh

mkdir -p $WDIR/var/empty/sshd
chmod 711 $WDIR/var/empty/sshd

echo "nameserver 10.0.2.3" > $WDIR/etc/resolv.conf
cp -r $2/perf $WDIR/

mkdir -p $WDIR/root/.ssh
cp /root/.ssh/authorized_keys $WDIR/root/.ssh
for f in `ls /root/.ssh/*.pub` ; do
  cat $f >> $WDIR/root/.ssh/authorized_keys
  echo "" >> $WDIR/root/.ssh/authorized_keys
done

rm -f $unsorted

printf "done.\n"
