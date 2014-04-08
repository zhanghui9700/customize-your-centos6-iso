#!/bin/bash

echo "
i'll mount you ISO file on /mnt/cdrom,and create directory '/data/OS' as base directory to create ISO
"

if [ ! -d "/mnt/cdrom/repodata" ];then
    iso=$1

    if [ ! $iso ];then
        echo 
        echo  "Usage Like: sh prepare_env.sh /opt/CentOS-6.5-x86_64-bin-DVD1.iso"
        echo 
        exit 1
    else
        mount -o loop $1 /mnt/cdrom
    fi
fi

rpm -q createrepo

if [ "$?" != "0" ];then
    yum -y install createrepo mkisofs rsync
fi


if [ ! -d "/data/OS" ];then
    mkdir -p /data/OS
fi

rsync -av --exclude=Packages/ --exclude=repodata/ /mnt/cdrom/ /data/OS/

echo "
now you can do next:
    1: mv the packages which you want to /data/OS/Packages/
    2: create you vi /data/OS/isolinux/ks.cfg manual
    3: modify /data/OS/isolinux/isolinux.cfg to your env

after all of above:
   run  createrepo.sh
"

