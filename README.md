# gwencam

## Version 0.1 - "Effervescing Elephant"

### Hardware
TODO: kit list

### Software
Bare minimum:
* detect motion
* image capture
* video capture
* remote access
* local network access
* basic admin
* FOSS

The quickest solution is therefore motionEyeOS. But with a view to either provide customisations to this software or to create something more custom, while adhering to the principles of being decent human beings and sharing cool stuff.

### Basic First Attempt
On your phone:
* install Fing (optional, but handy)
* install JuiceSSH (really kind of mandatory for admin)
* create an access point

On your (preferably linux) machine:
* format microSD to full capacity
* download image
* blkid
* ./writeimage.sh -d /dev/mmcblk(0?) -i "/path/to/motioneyeos.img" -n 'apn_name:apn_key' 

*[try etcher.io if failing]

*[TODO: figure out if wpa_supplicant.conf /boot drop is better, and iif so can have multiple apn?]

*[TODO: find out if network drop causes reboots, if so can only has *always on* or can has no checks?]

Assemble Zero W with camera, card, and storage as required....Start your access point!...POWER UP!!

First Boot:
When booting a fresh image installation, a few initialisation steps will take place and therefore the system won't be ready for about 1-2 minutes. Please do not disconnect or reboot "gwencam" during these first two minutes! 

Steps are:
* preparing the data partition on the SD card
* configuring SSH remote access
* auto-configuring any detected camera devices
* connecting to network defined during ./writeimage

As soon as "gwencam" is ready it will listen on port 80 and present a WUI. 

To access it, enter the IP address of your board in the address bar of your browser.

IP address can be found from access point.

Click on the user icon on the upper-left side of the page to switch user to administrator. 

Use "admin" with no password when asked for credentials....

### to be continued...
