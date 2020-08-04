#!/bin/bash

#Utilisation :    jackstart usb true  #true for reset modules


echo "---------request kill pulseaudio"
pulseaudio -k; 
echo "----------Killing jack server instances"
killall jackd;
echo "----------Killing pulse audio instances"
killall pulseaudio;
#sera start avec pulseaudio



#echo "set-default-sink jack_out" | pacmd
#echo "set-default-source jack_in" | pacmd

#jackd -T -ndefault -dalsa -dhw:USB,0 -r44100 -p1024 -n2 &

#Actual presonus Audio box
#jackd -R -ndefault -dalsa -dhw:USB,0 -r44100 -p1024 -n2 &
echo "--------------- run jackd----------"

#echo "device: -dhw:1,0"
#jackd -R -ndefault -dalsa -dhw:1,0 -r44100 -p1024 -n2 &

##Start jack on HDMI ASUS Screen (works)
#echo "device: -dhw:0,3  (HDMI)"
#jackd -R -ndefault -dalsa -dhw:0,3 -r44100 -p1024 -n2 &

if  [ $1 == "usb" ]; then
##Works , for usb scarlett 2i4
    echo "device: -dhw:USB,0 (USB)"
    jackd -R -ndefault -dalsa -dhw:USB,0 -r44100 -p1024 -n2 &

else
    ##Start jack on HDMI ASUS Screen (works)
    echo "device: -dhw:0,3  (HDMI)"
    jackd -R -ndefault -dalsa -dhw:0,3 -r44100 -p1024 -n2 &
fi 





echo "------------ Running qjack ctl"
qjackctl &



if  [ -z "$2" ]; then
   echo "No changes for modules"
else
 echo " Unloading modules"
    pactl unload-module module-jack-sink 
    pactl unload-module module-jack-source
    echo " Loading modules"
    pactl load-module module-jack-sink 
    pactl load-module module-jack-source
fi 


#qjackctl &
#start auto reborn jack verification
rebornjack &
