#!/bin/bash
# Achintha Gunasekara
# 2015-05-20
# Script to Setup Wifi Network on a give SSID

WIFI_NETWORK_NAME="Wireless Network"
WIFI_PASSWORD="Wireless Password"

AIRPORT=$(networksetup -listallhardwareports |grep -A1 "Wi-Fi" |grep -v "Wi-Fi" |sed 's/.* //')
echo 'Airport is $AIRPORT'
networksetup -setairportpower $AIRPORT off
networksetup -setairportpower $AIRPORT on
sleep 2
 
if networksetup -getairportnetwork $AIRPORT | grep -i -a $WIFI_NETWORK_NAME ;
then
    echo 'Connected to wireless network $WIFI_NETWORK_NAME successfully!';
    exit 0
fi
 
if networksetup -setairportnetwork $AIRPORT $WIFI_NETWORK_NAME $WIFI_PASSWORD | grep -i -a "Failed" ;
then
    echo 'Failed to connect to $WIFI_NETWORK_NAME, just restarting...';
    networksetup -setairportpower $AIRPORT off
    networksetup -setairportpower $AIRPORT on
    sleep 1
fi
 
networksetup -getairportnetwork $AIRPORT
 
exit 0;
