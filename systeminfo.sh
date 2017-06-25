#!/bin/bash
temperature=`/opt/vc/bin/vcgencmd measure_temp`
ram=`free -h  | grep "Mem" | awk '{print "RAM(Free/Total):", $4,"/",$2}'`
cpu=`top -n 1 | head -n 8 | tail -n 1| awk '{print "CPU used: ",$10, "%"}'`
sd=`df -Bh | awk  '/root/ {print "SDCard(Free/Total): ", $4,"/",$2}'`
echo $temperature". "$ram". "$cpu". "$sd
