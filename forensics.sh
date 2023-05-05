#!/usr/bin/bash

collectInfo(){
echo "Gathering information about the system ...."
touch systeminfo.txt
echo "--------system information--------" > systeminfo.txt
echo "hostname : " $(hostname) >> systeminfo.txt
echo "kernel info : " $(uname -v) >> systeminfo.txt
echo "archtictiure : " $(uname -m) >> systeminfo.txt
echo "TimeZone : " $(date | cut -d " " -f 7) >> systeminfo.txt
echo "system up time : " $(uptime) >> systeminfo.txt
echo "--------storage information--------" >> systeminfo.txt
echo "storage info : " >> systeminfo.txt
lsblk >> systeminfo.txt
echo "--------network information--------" >> systeminfo.txt
echo "Routing table : " >> systeminfo.txt
route >> systeminfo.txt
echo "ARP table : " >> systeminfo.txt
arp -a >> systeminfo.txt
}

memoryAcquire(){
if [ $(id -u) == 0 ]
then
echo "[*] Memory Imaging ..."
chmod +x avml
sudo ./avml MemoryImage.mem
else
echo "this option requires root privillage, please re-run the script with sudo"
fi
}

usbInfo(){
echo "Gathering information about USBs ...."
touch usbinfo.txt
dmesg | grep usb > usbinfo.txt
}

if [ "$1" == "" ]
then 
echo "Linux Live Data Acqusition Automation Tool by Mohab Mustafa"
echo "Best Practise is to run this script on external storage device"
echo "Usage : ./collector options CaseName"
echo "options : 
1 : collect information about system
2 : memory Image
3 : usb info
4 : all
"
echo "example ./collector 3 LinuxMachine"
else
mkdir $2
if [ "$1" == 1 ]
then
cd $2
collectInfo
echo "Output : $2/systeminfo.txt"
fi

if [ "$1" == 2 ]
then
cd $2
memoryAcquire
echo "Output : $2/MemoryImage.mem"
fi

if [ "$1" == 3 ]
then
cd $2
usbInfo
echo "Output : $2/usbinfo.txt"
fi

if [ "$1" == 4 ]
then
collectInfo
memoryAcquire
fi

fi