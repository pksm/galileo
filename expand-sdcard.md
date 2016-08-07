###Resize rootfs partition on Intel Galileo Gen 2

####Comands:

`fdisk /dev/mmcblk0`

Delete second partition /dev/mmcblk0p2:

```shell
d
2
```

Create a new primary partition, using default values:

```shell
n
p
2
<enter>
<enter>
w
```

Apply changes:

`reboot`

Resize filesystem and last reboot:
```shell
resize2fs /dev/mmcblk0p2
reboot
```

Check new amount of available disk space:

`df -h`
