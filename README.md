# gwencam

## Version 0.2 - "Birdie Hop"
Feel free to edit this document. I will explain git and repo's another time, click on README.md link and then on the little pencil icon to edit....scroll down to the bottom of the page to save/commit the file....you can't break anything that itsn't fixable. :)

### Hardware
#### Kit List
* Pi Zero W (starter kit)
* Zero2Go (make sure you get a ferrite ring!) !DEPRECATED - UNTIL SOFTWARE BUG FIXED!
* Zero4U USB Hub

#### TODO: *assembling
* put the camera cable in the right way round!...it is fiddly.

### Software
Bare minimum:
* detect motion
* image capture
* video capture
* remote access
* local network access
* basic admin
* FOSS

The quickest solution is therefore basic "Motion". We start there, building on the work of others where possible...But with a view to either provide improvements to this software or to create something more custom, while adhering to the principles of being decent human beings and sharing cool stuff.

### Basic First Attempt
On your phone:
* install Fing (optional, but handy)
* install JuiceSSH (really kind of mandatory for admin)
* create an access point

On your PC:
* format microSD to full capacity (I use "SDFormatter" on Windows. Make sure you check the options to ensure you are expanding the whole capacity of the card)
* download Raspbian Jessie image from here: https://www.raspberrypi.org/downloads/raspbian/ (don't bother with the "lite" version)
* unzip that to get the image
* Download and install Etcher from http://etcher.io
* Using Etcher, select the unzipped image, and the drive you just formatted and burn it (it wil verify afterwards...so it takes a while)
* After burning you should be able to see a drive called "boot"
* Copy this file to the "boot" volume: https://github.com/guriben/gwencam/blob/master/ssh
* Copy this file to the "boot" volume (it can also be placed in /etc/wpa_supplicant/ if you have that path on the sd card: https://github.com/guriben/gwencam/blob/master/wpa_supplicant.conf
* Now you can unmount the SD card and put it in your Pi Zero W
* Power on the Pi - use the "usual" USB power connector on the Pi itself, we will not configure the Zero2Go yet.

* On a PC on the same Wifi Network you configured in "wpa_supplicant.conf", find out the IP address of the pi (it is called 'raspberrypi' or 'raspberrypi-N' where N is a number if you have more than one Pi connected) use something like "Fing" or connect to the router and have a look for it there, note the IP:
* ssh pi@192.xxx.xx.xxx - where x is the IP, duh :) the *default* password is "raspberry" (without quotes)

Now you are connected to your Pi we need to do some initial configuration.
* Change default password, we used *gwencam1* for simplicity, to do that just type "passwd" and follow the 2 prompts.
* Make sure the system is up to date....
* Type or copy paste.....[Shift]+[Insert] is paste on Linux terminal...the following:

sudo apt-get update && sudo apt-get upgrade -y

* when that has finished, if not prompted to do so, do a restart:

sudo reboot now

* When the system reboots, check for the new IP (it might be the same, but check) and this time after "ssh pi@xx.xxx.xx.xxx" use the new password you just set.
* Just a few more things...now run:

sudo raspi-config

...and arrow down to Interfaces, press enter and enable all of them (there a couple of prompts for each one, use arrow keys, and tab or enter to move around and select, escape key takes you back one menu).

* Exit saving changes and then (you will probably be prompted to do so anyway...but):

sudo reboot now

* Repeat the connection steps before we move onto Zero2Go....

wget http://www.uugear.com/repo/Zero2Go/installZero2Go.sh

* If your Raspberry Pi has internet connection, it will immediately download the script. Now run it with sudo:

Now we need to install Motion *properly* and not quite how I tried to do it.

* You should be logged back into your pi over ssh
* Use the following command:

wget github.com/Motion-Project/motion/releases/download/release-4.0

* When that completes, type this (answer "y" if prompted):

sudo apt-get install gdebi-core

* When that completes, type this:

sudo gdebi pi_jessie_motion_4.0.1-1_armhf.deb

* Now we backup config file just in case:

mkdir ~/.motion

cp /etc/motion/motion.conf ~/.motion/motion.conf

(if you get a permission denied error try: sudo cp /etc/motion/motion.conf ~/.motion/motion.conf)

* Edit the motion configuration [TODO: Ben to provide a drop in replacement file]
sudo nano ~/.motion/motion.conf
* Make the following changes:

* - Uncomment the mmalcam_name vc.ril.camera parameter.
* - Uncomment target_dir and change it's associated value to ’/home/pi/Documents/motion’
* - Ensure that ffmpeg_output_movies is set to 'off'
* - Set stream_localhost to ‘off’
* - Set webcontrol_localhost to 'off’
* - Set width to ‘640’ and height to ‘480’
* - Set locate_motion_mode to ‘preview’
* - Set locate_motion_style to ‘redbox’
* - Set event_gap to '10'
* - Set output_pictures to 'center'
* - Set quality to '80'
* - Set text_changes to 'on'

* Save the file

* Start motion for the first time (keep an eye open for error messages):

motion -c ~/.motion/motion.conf

* Now on a phone, or PC connected to the same Wifi access point as your Pi you should be able to go to:

http://ip.address.of.pi:8180

* ...and should see some video...motion is indicated by a having a red box drawn around it.

* Finally, for now, we want it to start at boot time....
* Back in the SSH window to your Pi, press Ctrl+C to stop motion
* Edit the following file:

sudo nano /etc/rc.local

* to the end of the file add the line:

motion -c ~/.motion/motion.conf &

* Over time your SD card will fill up with images, so we will need some clean up scripts....Ben TODO

* Next step will be to add some fancier detection and triggers for action when motion is detected.

:)

### to be continued...
