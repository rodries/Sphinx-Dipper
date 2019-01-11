# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {'
kernel.string=Sphinx Kernel v2.x by milouk @xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=dipper
supported.versions=9,9.0
'} # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=auto;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

ui_print "           _____       _     _             "
ui_print "          / ____|     | |   (_)            "
ui_print "         | (___  _ __ | |__  _ _ __ __  __ "
ui_print "          \___ \| '_ \| '_ \| | '_ \\ \/ / "
ui_print "          ____) | |_) | | | | | | | |>  <  "
ui_print "         |_____/| .__/|_| |_|_|_| |_/_/\_\ "
ui_print "                | |                        "
ui_print "                |_|                        "
ui_print "$compatibility_string";

## Trim partitions
ui_print " "
#ui_print "Triming cache & data partitions..."
#fstrim -v /cache;
#fstrim -v /data;


ui_print "Decompressing image kernel..."
ui_print "This might take some seconds."
## AnyKernel install
dump_boot;

# ramdisk patch
#ramdisk_patch;

# end ramdisk changes

ui_print "Regenerating image kernel and installing..."
write_boot;

## end install

