#!/bin/sh

PROC_JEEDOM=`ps -ef | grep nodejs | grep jeedom`
LED_JEEDOM="verte"

INET=`ping -q -c 1 -W 1 8.8.8.8 >/dev/null && echo "0"`
LED_INET="rouge"

WIFI=`ping -q -c 1 -W 1 192.168.25.254 >/dev/null && echo "0"`
LED_WIFI="bleue"

Jeedom(){
  set -- ${PROC_JEEDOM}
  PID=$2
  if [ ! -z "$PID" ]  ; then
        /usr/bin/python /opt/scripts/myLED.py Allumer ${LED_JEEDOM}
        echo "Jeedom started!" 
  else 
        /usr/bin/python /opt/scripts/myLED.py Eteindre ${LED_JEEDOM}
        echo "Jeedom not started!"
  fi
}

Inetv4(){
        #if ifconfig eth0 | grep -q "inet addr:" ; then
        if [ ${INET} -eq 0 ] ; then
                /usr/bin/python /opt/scripts/myLED.py Allumer ${LED_INET}
                echo "IPv4 is up!"
        else
                /usr/bin/python /opt/scripts/myLED.py Eteindre ${LED_INET}
                echo "IPv4 is down!"
        fi
}

Wifi(){
        #if ifconfig wlan0 | grep -q "inet addr:" ; then
        if [ ${WIFI} -eq 0 ] ; then
                /usr/bin/python /opt/scripts/myLED.py Allumer ${LED_WIFI}
                echo "Wireless connection up!"
        else
                /usr/bin/python /opt/scripts/myLED.py Eteindre ${LED_WIFI}
                echo "Wireless connection down! Attempting reconnection."
                ifup --force wlan0
        fi
}
