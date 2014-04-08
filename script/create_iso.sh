#!/bin/bash

os_name=EayunCloudOS-x86_64.iso

if [ -f "/data/$os_name" ];then
    echo "/data/$os_name" is exits,back it
    mv /data/$os_name /data/$os_name+_back
fi

dir_name=$(cd `dirname $0`; pwd)

source_os_dir=/mnt/cdrom
os_dir=/data/OS/

rsync -av $dir_name/files/ /data/OS/

cd $os_dir
rm -rf repodata/*
cp /mnt/cdrom/repodata/*x86_64*.xml repodata/
createrepo -g /data/OS/repodata/*x86_64*.xml $os_dir
declare -x discinfo=`head -1 .discinfo`
createrepo -u "media://$discinfo" -g /data/OS/repodata/*x86_64*.xml $os_dir

mkisofs -R -T -r -l -d -allow-multidot -allow-leading-dots -no-bak -o /data/$os_name -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table /data/OS

#inside md5
implantisomd5 /data/$os_name

#check iso md5
#checkisomd5 /data/$os_name


echo -e "\n********************************************************"
echo "**   ISO is created at /data/$os_name   **"
echo -e "********************************************************\n"
