#!/system/bin/sh

while [ ! -d /dev/block/mapper ]; do
    sleep 1
done

ln -s /dev/block/mapper/* /dev/block/bootdevice/by-name/

exit 0
